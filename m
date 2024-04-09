From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 09 Apr 2024 12:02:44 -0000
Subject: [PATCH 0/9] rtc: convert multiple bindings into dtschema
In-Reply-To: <20240409102658d86fb2bd@mail.local>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240409102658d86fb2bd@mail.local>
Message-ID: <a4283479-2c4a-4f8f-b224-999dd12ba009@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/9/24 12:26, Alexandre Belloni wrote:
> On 08/04/2024 17:53:00+0200, Javier Carrasco wrote:
>> This series converts the following bindings into dtschema, moving them
>> to trivial-rtc whenever possible:
>>
>> - orion-rtc: trival-rtc, referenced in arm arch.
>> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
>> - lpc32xx-rtc: trival-rtc, referenced in arm arch.
>> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
>> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
>> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
>> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
>> - stmp3xxx-rtc: convert, referenced in arm arch.
>> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.
> 
> Probably all the moves to trivial-rtc can be squashed.
> 

Sure, I will squash them for v2.

Best regards,
Javier Carrasco

