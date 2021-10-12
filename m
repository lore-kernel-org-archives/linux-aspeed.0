From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Tue, 12 Oct 2021 23:15:00 +0000
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <YWStQSrRJQ09KXVY@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <YWSZTq8NWWcCMXtA@zn.tnic>
 <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
 <YWStQSrRJQ09KXVY@zn.tnic>
Message-ID: <15d81463b631e03b00a7031510304d5598fc246c.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-10-11 at 23:31 +0200, Borislav Petkov wrote:
> On Mon, Oct 11, 2021 at 08:38:43PM +0000, Winiarska, Iwona wrote:
> > Everything that's part of this series runs on the BMC (Baseboard
> > Management Controller). There's nothing ARM specific to it - it's just
> > that the BMC hardware we're currently supporting is ARM-based. PECI is
> > an interface that's exposed by some x86 CPUs - but that's a hardware
> > interface (available completely independent from whatever is actually
> > running on the x86 CPU).
> 
> Aha, I think I got it: so this whole PECI pile is supposed to run on
> the BMC - which can be ARM but doesn't have to be, i.e., code should be
> generic enough - and the interfaces to the x86 CPU do get exposed to the
> Linux running on the BMC.
> 
> Which brings me to the answer to your other mail:
> 
> On Mon, Oct 11, 2021 at 07:32:38PM +0000, Winiarska, Iwona wrote:
> > Nothing wrong - just a trade-off between churn and keeping things tidy
> > and not duplicated, similar to patch 1. And just like in patch 1, if
> > you have a strong opinion against it - we can duplicate.
> 
> So it is not about strong opinion. Rather, it is about whether this
> exporting would be disadvantageous for x86 freedom. And I think it will
> be:
> 
> Because if you exported those and then we went and changed those
> interfaces and defines (changed their naming, function arguments,
> whatever) and something outside of x86 used them, we will break that
> something.
> 
> And usually we go and fix those users too but I doubt anyone has access
> to that PECI hw to actually test fixes, etc, etc.

We (OpenBMC) do have PECI HW, so that shouldn't be a problem.

> So I'd prefer the small amount of duplication vs external stuff using
> x86 facilities any day of the week. And so I'd suggest you simply copy
> the handful of functions and defines you're gonna be needing and the
> defines and be done with it.
> 
> Dave's idea makes sense to me too but lately it keeps happening that
> we change something in x86-land and it turns out something "from the
> outside" is using it and it breaks, so it is a lot easier if things are
> independent.

Both CPUID.EAX=1 decoding and definitions in intel-family are pretty "well-
defined". I understand the scenario that you're describing, but in order to
break the outside user there would need to be some "logic" behind the pulled in
concepts (if, for example, I would use something like X86_MATCH_* defines in
PECI).

Thanks
-Iwona

> 
> Thx.
> 

