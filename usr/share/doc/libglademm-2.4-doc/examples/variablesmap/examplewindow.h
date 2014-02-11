//$Id: examplewindow.h 726 2004-09-19 12:55:53Z murrayc $ -*- c++ -*-

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

#ifndef GTKMM_EXAMPLE_WINDOW_H
#define GTKMM_EXAMPLE_WINDOW_H

#include <libglademm/variablesmap.h>
#include <gtkmm/button.h>
#include <gtkmm/window.h>

class ExampleWindow : public Gtk::Window
{

public:
  ExampleWindow();
  virtual ~ExampleWindow();

protected:
  //Signal handlers:
  virtual void on_button_clicked();
  virtual void on_file_exit();
  virtual void on_file_new();
  virtual void on_info();

  Glib::RefPtr<Gnome::Glade::Xml> m_refGlade;
  Gnome::Glade::VariablesMap* m_pVariablesMap;

  //Variables:
  Glib::ustring m_strEntry;
  Glib::ustring m_strCombo;
  Glib::ustring m_strSpinButton;
  bool m_bCheckBox;
  double m_dHScale;
  double m_dVScale;
  Glib::Date m_dateCalendar;
};

#endif // GTKMM_EXAMPLE_WINDOW_H
