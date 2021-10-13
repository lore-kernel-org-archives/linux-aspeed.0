From: Borislav Petkov <bp@alien8.de>
Date: Wed, 13 Oct 2021 08:42:06 +0200
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <15d81463b631e03b00a7031510304d5598fc246c.camel@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <YWSZTq8NWWcCMXtA@zn.tnic>
 <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
 <YWStQSrRJQ09KXVY@zn.tnic>
 <15d81463b631e03b00a7031510304d5598fc246c.camel@intel.com>
Message-ID: <YWZ/vqHXibwOWtDu@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 12, 2021 at 11:15:00PM +0000, Winiarska, Iwona wrote:
> We (OpenBMC) do have PECI HW, so that shouldn't be a problem.

Yeah, don't take it personally, but asking people to test stuff for you
doesn't really work, in practice.

> Both CPUID.EAX=1 decoding and definitions in intel-family are pretty "well-
> defined".

Sure, they are "well-defined" until we change them for whatever reason.
Then they will be "well-defined" again. But different.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
