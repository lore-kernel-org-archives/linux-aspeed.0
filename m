From: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 11 Oct 2021 16:12:20 -0700
Subject: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
In-Reply-To: <43e367e452c6c8d9c6a275299d7ff6f2bb26b8e3.camel@intel.com>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <67f2cfda-c78b-6282-f5a3-2f345f8e2849@intel.com>
 <43e367e452c6c8d9c6a275299d7ff6f2bb26b8e3.camel@intel.com>
Message-ID: <18cd5f4a-452b-f043-5686-fc5af47eb5ac@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/11/21 1:53 PM, Winiarska, Iwona wrote:
>> If you're in include/linux/x86-hacks.h, what prevents you from doing
>>
>> #include "../../arch/x86/include/asm/intel-family.h"
>>
>> ?
>>
>> In the end, to the compiler, it's just a file in a weird location in the
>> tree.  I think I'd prefer one weird include to moving that file out of
>> arch/x86.
> Using relative includes in include/linux is uncommon (I can see just one usage
> in libfdt.h pulling stuff from scripts), so I thought I can't use it in this way
> (seems slightly hacky to pull stuff from outside include path).
> 
> But if that would be ok, it looks like a good alternative to avoid duplication
> in this case.

If you don't want to do it from a header, you can also do it directly
from a .c file that's outside of arch/x86.

I think that's a much better alternative than moving stuff elsewhere.
