From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 21:04:08 +0200
Subject: [PATCH v1 01/14] serial: core: Move struct uart_port::quirks
 closer to possible values
In-Reply-To: <20240221135452.6fdeb71e60509cca1be016c3@hugovil.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-2-andriy.shevchenko@linux.intel.com>
 <20240221135452.6fdeb71e60509cca1be016c3@hugovil.com>
Message-ID: <ZdZJKIrkeasBwL3i@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 21, 2024 at 01:54:52PM -0500, Hugo Villeneuve wrote:
> On Wed, 21 Feb 2024 20:31:17 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Currently it's not crystal clear what UPIO_* and UPQ_* definitions
> > belong two. Reindent the code, so it will be easy to read and understand.
> 
> two -> to.

Ah, thanks, will fix!

-- 
With Best Regards,
Andy Shevchenko


