From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 4 Mar 2024 13:09:07 +0200
Subject: [PATCH v2 03/14] serial: port: Introduce a common helper to read
 properties
In-Reply-To: <2024030259-playback-starlit-a472@gregkh>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-4-andriy.shevchenko@linux.intel.com>
 <2024030259-playback-starlit-a472@gregkh>
Message-ID: <ZeWr06YWj5cDHfWL@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Mar 02, 2024 at 09:58:53PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 26, 2024 at 04:19:19PM +0200, Andy Shevchenko wrote:

...

> > + * uart_read_port_properties - read firmware properties of the given UART port
> 
> I like, but:
> 
> > + * @port: corresponding port
> > + * @use_defaults: apply defaults (when %true) or validate the values (when %false)
> 
> Using random booleans in a function is horrid.  Every time you see the
> function call, or want to call it, you need to go and look up what the
> boolean is and means.
> 
> Make 2 public functions here, one that does it with use_defaults=true
> and one =false and then have them both call this one static function,
> that way the function names themselves are easy to read and understand
> and maintain over time.

Okay! I'll redo that.

...

> > +EXPORT_SYMBOL(uart_read_port_properties);
> 
> EXPORT_SYMBOL_GPL()?  I have to ask :)

No clue, the rest in this file is EXPORT_SYMBOL, but I admit I followed the
cargo cult. I'll check the modified code and see if I may use _GPL version.

Thank you for review!

-- 
With Best Regards,
Andy Shevchenko


