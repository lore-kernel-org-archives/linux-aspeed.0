From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 22 Nov 2021 17:32:43 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}()
 helpers
In-Reply-To: <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
 <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
Message-ID: <01b44b38c087c151171f8d45a2090474c2559306.camel@sipsolutions.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-11-22 at 16:53 +0100, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 

I'm not sure it's really a good idea to add a third API here?

We have the upper-case (constant) versions, and already
{u32,...}_get_bits()/etc.

Also, you're using __ffs(), which doesn't work for 64-bit on 32-bit
architectures (afaict), so that seems a bit awkward.

Maybe we can make {u32,...}_get_bits() be doing compile-time only checks
if it is indeed a constant? The __field_overflow() usage is already only
done if __builtin_constant_p(v), so I guess we can do the same with
__bad_mask()?

johannes
