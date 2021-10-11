From: Borislav Petkov <bp@alien8.de>
Date: Mon, 11 Oct 2021 22:06:38 +0200
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
Message-ID: <YWSZTq8NWWcCMXtA@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 11, 2021 at 07:21:26PM +0000, Winiarska, Iwona wrote:
> Same reason why PECI can't just include arch/x86 directly (we're building for
> ARM, not x86).

Aha.

So what do you need those INTEL_FAM6* defines for?

I see peci_cpu_device_ids[] which are used to match the CPU so at least
that thing must be loading on x86 hardware... reading your 0th message,
it sounds like that peci-cpu thing is loaded on an x86 CPU and it then
exposes those interfaces which a PECI controller accesses.

And then I see in init_core_mask() the single usage of INTEL_FAM6* and
that drivers/hwmon/peci/cputemp.c is a CPU temp monitoring client so
that thing probably runs on x86 too.

Or?

If it does, then you don't need the code move.

But it looks like I'm missing something...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
