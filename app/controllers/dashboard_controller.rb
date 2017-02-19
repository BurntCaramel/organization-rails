class DashboardController < ApplicationController
  include ActionView::Helpers::UrlHelper

  before_action :set_current_user

  def index
    @callback_url = "#{ root_url }auth/auth0/callback"

    @intro = %{
<h1>Low fidelity prototyping lets you get high fidelity answers sooner</h1>

<h2>Prototype landing pages, forms, emails, and flows.</h2>

Start with plain text and progress from basic meaning to rich interactivity.

Get the essentials of content and flow right before the details. Then preview as interactive Bootstrap 4, Material, Foundation, or vanilla web app.

The sooner you can create something to show people, the sooner you can hear feedback.

<h2>Features</h2>

- Annotate content using #hashtags
- Import text, images, and spreadsheets
- <em>Coming soon:</em> make your own reusable components.

<h2>Start with user stories, iterate your content, and create interactive prototypes.</h2>

<h2>Content-first design is recommended by many in the industry:</h2>

<blockquote>
The goal of the prototype is to write the conversation we want to have with someone, then design an experience that best brings that conversation to life
<p>#{ link_to 'Steph Hay on Content-First Design', 'http://alistapart.com/blog/post/content-first-design' }</p>
</blockquote>
    }
  end
end
