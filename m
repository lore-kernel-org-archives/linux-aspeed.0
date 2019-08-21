From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 21 Aug 2019 05:39:33 -0700
Subject: [PATCH v3 11/11] RFC: watchdog: export core symbols in
 WATCHDOG_CORE namespace
In-Reply-To: <20190821114955.12788-12-maennich@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-12-maennich@google.com>
Message-ID: <20190821123933.GC4059@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2019 at 12:49:26PM +0100, Matthias Maennich wrote:
> Modules using these symbols are required to explicitly import the
> namespace. This patch was generated with the following steps and serves
> as a reference to use the symbol namespace feature:
> 
>  1) Use EXPORT_SYMBOL_NS* macros instead of EXPORT_SYMBOL* for symbols
>     in watchdog_core.c
>  2) make  (see warnings during modpost about missing imports)
>  3) make nsdeps
> 
> I used 'allmodconfig' for the above steps to ensure all occurrences are
> patched.
> 
> Defining DEFAULT_SYMBOL_NAMESPACE in the Makefile is not trivial in this
> case as not only watchdog_core is defined in drivers/watchdog/Makefile.
> Hence this patch uses the variant of using the EXPORT_SYMBOL_NS* macros
> to export into a different namespace.
> 
> An alternative to this patch would be a single definition line before
> any use of EXPORT_SYMBOL*:
>  #define DEFAULT_SYMBOL_NAMESPACE WATCHDOG_CORE
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>

As we talked in chat, the cc: list for this patch was crazy :)

If you end up resending this (as odds are the mailing lists will trash
it for too many recipients), feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Great work,

greg k-h
