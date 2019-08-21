From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 21 Aug 2019 06:37:37 -0700
Subject: [PATCH v3 00/11] Symbol Namespaces
In-Reply-To: <nycvar.YSQ.7.76.1908210840490.19480@knanqh.ubzr>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <nycvar.YSQ.7.76.1908210840490.19480@knanqh.ubzr>
Message-ID: <20190821133737.GB4890@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2019 at 08:46:47AM -0400, Nicolas Pitre wrote:
> On Wed, 21 Aug 2019, Matthias Maennich wrote:
> 
> > As of Linux 5.3-rc5, there are 31205 [1] exported symbols in the kernel.
> > That is a growth of roughly 1000 symbols since 4.17 (30206 [2]).  There
> > seems to be some consensus amongst kernel devs that the export surface
> > is too large, and hard to reason about.
> 
> This is good work.
> 
> One solution for drastically reducing the effective export surface is to 
> have CONFIG_TRIM_UNUSED_KSYMS=y. This is more extreme than symbol 
> namespace, but might be worth mentioning nevertheless.

Oh that's amazing, I never noticed that feature.  That is a nice thing,
thanks for pointing it out.

greg k-h
