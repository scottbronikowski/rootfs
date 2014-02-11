#include <libglademm/xml.h>
#include <gtkmm.h>
#include <iostream>

Gtk::Dialog* pDialog = 0;

void on_button_clicked()
{
  if(pDialog)
    pDialog->hide(); //hide() will cause main::run() to end.
}

//This could be a member method (you might use get_widget_derived) instead,
//but I'm trying to keep this example simple. murrayc.
void on_menu_item_activated()
{
  std::cout << "menu item activated" << std::endl;
}

int main (int argc, char **argv)
{
  Gtk::Main kit(argc, argv);

  //Load the Glade file and instiate its widgets:
  Glib::RefPtr<Gnome::Glade::Xml> refXml;

#ifdef GLIBMM_EXCEPTIONS_ENABLED
  try
  {
    refXml = Gnome::Glade::Xml::create("example.glade");
  }
  catch(const Gnome::Glade::XmlError& ex)
  {
    std::cerr << ex.what() << std::endl;
    return 1;
  }
#else
  std::auto_ptr<Gnome::Glade::XmlError> error;
  refXml = Gnome::Glade::Xml::create("example.glade", "" , "", error);
  if(error.get())
  {
    std::cerr << error->what() << std::endl;
    return 1;
  }
#endif

  //Get the Glade-instantiated Dialog:
  
  refXml->get_widget("DialogBasic", pDialog);
  if(pDialog)
  {
    //Get the Glade-instantiated Button, and connect a signal handler:
    Gtk::Button* pButton = 0;
    refXml->get_widget("quit_button", pButton);
    if(pButton)
      pButton->signal_clicked().connect( sigc::ptr_fun(&on_button_clicked) );

    //Connect signal handlers for the menu items:

    Gtk::MenuItem* pMenuItem = 0;
    refXml->get_widget("menu_file_new", pMenuItem);
    if(pMenuItem)
      pMenuItem->signal_activate().connect( sigc::ptr_fun(&on_menu_item_activated) );

    refXml->get_widget("menu_file_save", pMenuItem);
    if(pMenuItem)
      pMenuItem->signal_activate().connect( sigc::ptr_fun(&on_menu_item_activated) );

    refXml->get_widget("menu_file_quit", pMenuItem);
    if(pMenuItem)
      pMenuItem->signal_activate().connect(sigc::ptr_fun(&on_button_clicked));

    kit.run(*pDialog);
  }

  return 0;
}

