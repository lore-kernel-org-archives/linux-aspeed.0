From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Mon, 11 Oct 2021 20:38:43 +0000
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <YWSZTq8NWWcCMXtA@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <YWSZTq8NWWcCMXtA@zn.tnic>
Message-ID: <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-10-11 at 22:06 +0200, Borislav Petkov wrote:
> On Mon, Oct 11, 2021 at 07:21:26PM +0000, Winiarska, Iwona wrote:
> > Same reason why PECI can't just include arch/x86 directly (we're building
> > for
> > ARM, not x86).
> 
> Aha.
> 
> So what do you need those INTEL_FAM6* defines for?

To identify the x86 CPU and use that as a match for binding PECI drivers.

> I see peci_cpu_device_ids[] which are used to match the CPU so at least
> that thing must be loading on x86 hardware... reading your 0th message,
> it sounds like that peci-cpu thing is loaded on an x86 CPU and it then
> exposes those interfaces which a PECI controller accesses.

Everything that's part of this series runs on the BMC (Baseboard Management
Controller). There's nothing ARM specific to it - it's just that the BMC
hardware we're currently supporting is ARM-based.
PECI is an interface that's exposed by some x86 CPUs - but that's a hardware
interface (available completely independent from whatever is actually running on
the x86 CPU).

> 
> And then I see in init_core_mask() the single usage of INTEL_FAM6* and
> that drivers/hwmon/peci/cputemp.c is a CPU temp monitoring client so
> that thing probably runs on x86 too.

That also runs on BMC, it uses functionality offered by peci-cpu to expose hwmon
interface to userspace.
Userspace that makes use of that hwmon interface also runs on the BMC and
exposes sensor data to user (via redfish API, or web-based interface).

> Or?
> 
> If it does, then you don't need the code move.
> 
> But it looks like I'm missing something...
> 

I'm sorry - it looks that my description in the cover letter wasn't clear
enough.

Thanks
-Iwona

