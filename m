From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 21 Aug 2019 06:38:46 -0700
Subject: [PATCH v3 00/11] Symbol Namespaces
In-Reply-To: <20190821131140.GC2349@hirez.programming.kicks-ass.net>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821131140.GC2349@hirez.programming.kicks-ass.net>
Message-ID: <20190821133846.GC4890@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2019 at 03:11:40PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 21, 2019 at 12:49:15PM +0100, Matthias Maennich wrote:
> > As of Linux 5.3-rc5, there are 31205 [1] exported symbols in the kernel.
> > That is a growth of roughly 1000 symbols since 4.17 (30206 [2]).  There
> > seems to be some consensus amongst kernel devs that the export surface
> > is too large, and hard to reason about.
> > 
> > Generally, these symbols fall in one of these categories:
> > 1) Symbols actually meant for drivers
> > 2) Symbols that are only exported because functionality is split over
> >    multiple modules, yet they really shouldn't be used by modules outside
> >    of their own subsystem
> > 3) Symbols really only meant for in-tree use
> > 
> > When module developers try to upstream their code, it regularly turns
> > out that they are using exported symbols that they really shouldn't be
> > using. This problem is even bigger for drivers that are currently
> > out-of-tree, which may be using many symbols that they shouldn't be
> > using, and that break when those symbols are removed or modified.
> > 
> > This patch allows subsystem maintainers to partition their exported
> > symbols into separate namespaces, and module authors to import such
> > namespaces only when needed.
> > 
> > This allows subsystem maintainers to more easily limit availability of
> > these namespaced symbols to other parts of the kernel. It can also be
> > used to partition the set of exported symbols for documentation
> > purposes; for example, a set of symbols that is really only used for
> > debugging could be in a "SUBSYSTEM_DEBUG" namespace.
> 
> I'm missing how one can prohibit these random out of tree modules from
> doing MODULE_IMPORT_NS().

Nothing, but then they are explicitly being "bad" :)

> That is; suppose I stick all the preempt_notifier symbols in a KVM
> namespace, how do I enforce no out-of-tree modules ever do
> MODULE_IMPORT_NS(KVM) and gain access?
> 
> (the above would basically break virtualbox, which I knows uses preempt
> notifiers too, but I don't give a rats arse about that)

It's a huge red flag for anyone reviewing the code that this module is
doing something it probably really should not be doing at all.  It will
make reviewing code easier, this isn't there to try to "prevent bad
actors" at all, sorry.

thanks,

greg k-h
