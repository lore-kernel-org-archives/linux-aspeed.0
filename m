Return-Path: <linux-aspeed+bounces-726-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE96C02198
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 15:34:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvbgj0yG6z3blF;
	Sat, 15 Feb 2025 02:34:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739547249;
	cv=none; b=I+MxmVW1JDKL0wiHn4UUacEwi2eIyABglvF9PX0agEMfCFPU71aSoow/j4UfwIWzoVXSfCF6M5A159kpibqNJ/RIvIdyUzOStDoQf/MUmmt8SsljVDU/ZWLp8CCZcH3MJhpJTTUlj3ZnXmuLkAOtEvcnVH1xEuyfaK6DxhR4NN4CHY/Ie25UWn2D02qSVUnMRLJpf3qniVTGqOHcBbUtH3Ps4mGJNCF7XzEnb8Up+yRDpYJZsJdNeu0wrWqSLTVeWCfAEbEVGpwrJVgtUYMmKSyyTrbo8UyxHmu9YjI9PXiwMRdsyiiLVuK40Wchg5abK0MmKaCRtk11gVQ10TlwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739547249; c=relaxed/relaxed;
	bh=+UBhTHpXQ+XdamCLSlWS9cI3aGJ7aKK8OHT/Zn/M/Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJurbTz3+ClXSVPXgj5iiGGPrY7kNn+gccLAg4xJ11SJT+/FvtT0ZaGPwX38/t/EX6dnm6Xec9X5s8hG5OsaUyBzYYUUDY3ENhSwavCHUOiRJTzhY0OdIMIt6qBGlK1ePDxau498xUqioONZ243fUKcnXaEsVQm0ougFy6cTS3WzjRuItsBVP3i/LnsfRL8CzYIxLYYUsAjluVrXR13IsHooxr1rJ24CyCwF/RDfqToLHx7VQyz9D6HdOa3yJsdixaIW0gb6F8KIsqrdE0Kka0mBnhP0Z1xPBpRxzYsb+rcSTkx9UAp/Z/TjAUk7rm/Q3pCDChmJmAPQWpF54oiq5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ECrCiL7D; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ECrCiL7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yvbgh1tTGz2yGm
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 02:34:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E2035A42DD9;
	Fri, 14 Feb 2025 15:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E762C4CED1;
	Fri, 14 Feb 2025 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547244;
	bh=afzjkoDNR+5URzZhBvSQ4ZnpfxUfaPdGqiY8US/VboU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECrCiL7DBdPP6UFFz6PjonfFVlEUbl56ymR9CSiZzxpxCifwC27Tw8p1u6IDaNAcz
	 XemUEQwq0pq9I6NzQ57R87EtLHA58AoZUYXKU4c/a4+0bKli0nC2pWWJ0CaTzucIWf
	 zEEnZzErfP0wK5sPyu2mi2qclLmZogSRA/rGjbulFjwx2g9cjB/YQIACh2RMxA/mmG
	 B0Uv3e4Yr3cTk/XVs+liLdVf+fr5YxFQXWCevR4NaUolQnSHhBUYWJJ4xYbbe3NeAW
	 MF9KLwHoWvD7iUCoAoTnAelZhfw/GRKpfZBbyWOre6DjfvmbKONn7GTj2BMeFEUPTK
	 6xY1KtkqdoRBw==
Date: Fri, 14 Feb 2025 07:34:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250214073402.0129e259@kernel.org>
In-Reply-To: <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.

I really really think that people should just use the static inline
helpers if the field is not constant. And we should do something like
below so that people can actually find them.

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..e02afcd7aeee 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -156,6 +156,80 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * u32_encode_bits() - prepare a u32 bitfield element (non-const)
+ * @v: value to put in the field
+ * @field: shifted mask defining the field's length and position
+ *
+ * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
+{
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))
+		__field_overflow();
+	return ((v & field_mask(field)) * field_multiplier(field));
+}
+
+/**
+ * u32_replace_bits() - change a u32 bitfield element (non-const)
+ * @old: old u32 value to modify
+ * @val: value to put in the field
+ * @field: shifted mask defining the field's length and position
+ *
+ * Remove the current contents of the @field in @old and set it to @new.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline __u32 u32_replace_bits(__u32 old, u32 val, u32 field)
+{
+	return (old & ~(field)) | u32_encode_bits(val, field);
+}
+
+/**
+ * u32_get_bits() - get u32 bitfield element (non-const)
+ * @v: value to extract the field from
+ * @field: shifted mask defining the field's length and position
+ *
+ * Extract the value of the field and shift it down.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline u32 u32_get_bits(__u32 v, u32 field)
+{
+	return ((v) & field) / field_multiplier(field);
+}
+
+static __always_inline void u32p_replace_bits(__u32 * p, u32 val, u32 field)
+{
+	* p = ( * p & ~(field)) | u32_encode_bits(val, field);
+}
+
+static __always_inline __le32 le32_encode_bits(u32 v, u32 field)
+{
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))
+		__field_overflow();
+	return cpu_to_le32((v & field_mask(field)) * field_multiplier(field));
+}
+
+static __always_inline __le32 le32_replace_bits(__le32 old, u32 val, u32 field)
+{
+	return (old & ~cpu_to_le32(field)) | le32_encode_bits(val, field);
+}
+
+static __always_inline void le32p_replace_bits(__le32 * p, u32 val, u32 field)
+{
+	* p = ( * p & ~cpu_to_le32(field)) | le32_encode_bits(val, field);
+}
+
+static __always_inline u32 le32_get_bits(__le32 v, u32 field)
+{
+	return (le32_to_cpu(v) & field) / field_multiplier(field);
+}
+
+/* Auto-generate bit ops for other field width and endian combination */
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
@@ -198,7 +272,7 @@ static __always_inline base type##_get_bits(__##type v, base field)	\
 	____MAKE_OP(u##size,u##size,,)
 ____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
-__MAKE_OP(32)
+____MAKE_OP(be32,u32,cpu_to_be32,be32_to_cpu) /* Other 32b types open coded */
 __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP

