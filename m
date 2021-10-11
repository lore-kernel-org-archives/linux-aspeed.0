From: Borislav Petkov <bp@alien8.de>
Date: Mon, 11 Oct 2021 23:31:45 +0200
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <YWSZTq8NWWcCMXtA@zn.tnic>
 <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
Message-ID: <YWStQSrRJQ09KXVY@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 11, 2021 at 08:38:43PM +0000, Winiarska, Iwona wrote:
> Everything that's part of this series runs on the BMC (Baseboard
> Management Controller). There's nothing ARM specific to it - it's just
> that the BMC hardware we're currently supporting is ARM-based. PECI is
> an interface that's exposed by some x86 CPUs - but that's a hardware
> interface (available completely independent from whatever is actually
> running on the x86 CPU).

Aha, I think I got it: so this whole PECI pile is supposed to run on
the BMC - which can be ARM but doesn't have to be, i.e., code should be
generic enough - and the interfaces to the x86 CPU do get exposed to the
Linux running on the BMC.

Which brings me to the answer to your other mail:

On Mon, Oct 11, 2021 at 07:32:38PM +0000, Winiarska, Iwona wrote:
> Nothing wrong - just a trade-off between churn and keeping things tidy
> and not duplicated, similar to patch 1. And just like in patch 1, if
> you have a strong opinion against it - we can duplicate.

So it is not about strong opinion. Rather, it is about whether this
exporting would be disadvantageous for x86 freedom. And I think it will
be:

Because if you exported those and then we went and changed those
interfaces and defines (changed their naming, function arguments,
whatever) and something outside of x86 used them, we will break that
something.

And usually we go and fix those users too but I doubt anyone has access
to that PECI hw to actually test fixes, etc, etc.

So I'd prefer the small amount of duplication vs external stuff using
x86 facilities any day of the week. And so I'd suggest you simply copy
the handful of functions and defines you're gonna be needing and the
defines and be done with it.

Dave's idea makes sense to me too but lately it keeps happening that
we change something in x86-land and it turns out something "from the
outside" is using it and it breaks, so it is a lot easier if things are
independent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
