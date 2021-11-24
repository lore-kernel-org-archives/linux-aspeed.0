From: Kalle Valo <kvalo@codeaurora.org>
Date: Wed, 24 Nov 2021 10:24:02 +0200
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,
 get}() helpers
In-Reply-To: <CAMuHMdUnBgFpqhgjf5AA0LH9MZOFALeC=YinZ4Tv_V+Y9hkRSg@mail.gmail.com>
 (Geert Uytterhoeven's message of "Tue, 23 Nov 2021 09:30:14 +0100")
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
 <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
 <CAMuHMdUnBgFpqhgjf5AA0LH9MZOFALeC=YinZ4Tv_V+Y9hkRSg@mail.gmail.com>
Message-ID: <87sfvm55ct.fsf@codeaurora.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Johannes,
>
> On Mon, Nov 22, 2021 at 5:33 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>> On Mon, 2021-11-22 at 16:53 +0100, Geert Uytterhoeven wrote:
>> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
>> > constants.  However, it is very common to prepare or extract bitfield
>> > elements where the bitfield mask is not a compile-time constant.
>> >
>>
>> I'm not sure it's really a good idea to add a third API here?
>>
>> We have the upper-case (constant) versions, and already
>> {u32,...}_get_bits()/etc.
>
> These don't work for non-const masks.
>
>> Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
>> architectures (afaict), so that seems a bit awkward.
>
> That's a valid comment. Can be fixed by using a wrapper macro
> that checks if typeof(mask) == u64, and uses an __ffs64() version when
> needed.
>
>> Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
>> if it is indeed a constant? The __field_overflow() usage is already only
>> done if __builtin_constant_p(v), so I guess we can do the same with
>> __bad_mask()?
>
> Are all compilers smart enough to replace the division by
> field_multiplier(field) by a shift?

It looks like the answer is no as few weeks back I received a comment
internally that a team is seeing a slow down with u32_get_bits():

"Time taken for executing both the macros/inline function (in terms of microseconds)
(out of 3 Trails)
FIELD_GET	: 32, 31, 32
u32_get_bits	: 6379, 6664, 6558"

Sadly I didn't realise to ask what compiler they were using. But I still
prefer {u32,...}_get_bits() over FIELD_GET(), they are just so much
cleaner to use.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
