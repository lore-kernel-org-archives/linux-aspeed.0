From: Jiri Slaby <jirislaby@kernel.org>
Date: Fri, 23 Feb 2024 06:42:15 +0100
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <ZddKaaB7HO0CyldD@smile.fi.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
 <ZddKaaB7HO0CyldD@smile.fi.intel.com>
Message-ID: <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 22. 02. 24, 14:21, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
>> On 21. 02. 24, 19:31, Andy Shevchenko wrote:
> 
> ...
> 
>>>    	unsigned char		iotype;			/* io access style */
>>> +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
>>
>> Perhaps making the var u8 and this U8_MAX then? It would make more sense to
>> me.
> 
> WFM, should it be a separate change?

Likely.

> Btw, how can I justify it?

Hmm, thinking about it, why is it not an enum?

But it could be also an u8 because you want it be exactly 8 bits as you 
want to be sure values up to 255 fit.

thanks,
-- 
js
suse labs

