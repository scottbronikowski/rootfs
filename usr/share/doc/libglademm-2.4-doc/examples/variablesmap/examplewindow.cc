//$Id: examplewindow.cc 1099 2007-09-27 15:23:49Z arminb $ -*- c++ -*-

/* gtkmm example Copyright (C) 2002 gtkmm development team
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "examplewindow.h"
#include <iostream>
#include <gtkmm.h>

ExampleWindow::ExampleWindow()
: m_bCheckBox(0)
{
  // Sets the border width of the window.
  set_border_width(10);

  //Get Glade UI:
#ifdef GLIBMM_EXCEPTIONS_ENABLED
  try
  {
    m_refGlade = Gnome::Glade::Xml::create("example.glade");
  }
  catch(const Gnome::Glade::XmlError& ex)
  {
    std::cerr << ex.what() << std::endl;
    return;
  }
#else
  std::auto_ptr<Gnome::Glade::XmlError> error;
  m_refGlade = Gnome::Glade::Xml::create("example.glade", "", "", error);
  if(error.get())
  {
    std::cerr << error->what() << std::endl;
    return;
  }
#endif
  m_refGlade->reparent_widget("vbox", *this);

  m_pVariablesMap = new Gnome::Glade::VariablesMap(m_refGlade);
  m_pVariablesMap->connect_widget("entry", m_strEntry);
  m_pVariablesMap->connect_widget("checkbox", m_bCheckBox);
  m_pVariablesMap->connect_widget("comboboxentry", m_strCombo);
  m_pVariablesMap->connect_widget("spinbutton", m_strSpinButton);
  m_pVariablesMap->connect_widget("hscale", m_dHScale);
  m_pVariablesMap->connect_widget("vscale", m_dVScale);
  m_pVariablesMap->connect_widget("calendar", m_dateCalendar);

  //Connect button's signal handler:
  //Glade::Xml::connect_clicked() is a convenience method, which has nothing to do with the VariablesMap.
  m_refGlade->connect_clicked("button", sigc::mem_fun(*this, &ExampleWindow::on_button_clicked));
  m_refGlade->connect_clicked("file_new", sigc::mem_fun(*this, &ExampleWindow::on_file_new));
  m_refGlade->connect_clicked("file_exit", sigc::mem_fun(*this, &ExampleWindow::on_file_exit));
  m_refGlade->connect_clicked("help_info", sigc::mem_fun(*this, &ExampleWindow::on_info));

  show_all_children();
}

ExampleWindow::~ExampleWindow()
{
  if(m_pVariablesMap)
  {
    delete m_pVariablesMap;
  m_pVariablesMap = 0;
  }
}

void ExampleWindow::on_button_clicked()
{
  if(m_pVariablesMap)
    m_pVariablesMap->transfer_widgets_to_variables();

  std::cout << "Variable values: " << std::endl <<
    "  m_strEntry: " << m_strEntry << std::endl <<
    "  m_strCombo: " << m_strCombo << std::endl <<
    "  m_strSpinButton: " << m_strSpinButton << std::endl <<
    "  m_dHScale: " << m_dHScale << std::endl <<
    "  m_dVScale: " << m_dVScale << std::endl <<
    "  m_dateCalendar: " << m_dateCalendar.format_string("%d-%m-%y") << std::endl <<
    "  m_bCheckBox: " << (m_bCheckBox ? "true" : "false") << std::endl;
}

void ExampleWindow::on_file_exit()
{
	hide();
}

void ExampleWindow::on_file_new()
{
  m_strEntry.clear();
  m_strCombo.clear();
  m_strSpinButton.clear();
  m_dHScale = 50;
  m_dVScale = 50;
  m_dateCalendar.set_dmy(22, Glib::Date::OCTOBER, 1977); // Alberto's birthday :-)
  m_bCheckBox = true;
  
  if(m_pVariablesMap)
    m_pVariablesMap->transfer_variables_to_widgets();
}

void ExampleWindow::on_info()
{
  std::cout << "Info Selected" << std::endl;
}


