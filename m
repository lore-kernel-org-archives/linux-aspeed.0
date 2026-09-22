Return-Path: <linux-aspeed+bounces-5042-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B23C98302
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 16:04:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq4fG6KKJz2ySj;
	Wed, 23 Sep 2026 02:04:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::11" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790093046;
	cv=pass; b=CA1gDVshb0XmW22bOLMPUjOMgxK/lVUH6XejasCmU9szDkEAo0TqgdPPpWkDagrrgQaPFjEu33WxRIbd7ZDQOyNwrhM0Jno+eNxCmWRpfmV/ME9h82RzwsaOeLVZ7jzoV2fs6P9lEXz5OH8Q2OZz6P8jgHB0C/2Ytcn2GyvyS2qenTy/2rXwrB1urDX91xooA5UVAhsUfB8DO+hucrsimB5pXTYw5IjLX/m1QxWr31nqyiITl5O4Er5GqjdkepsjE27togRrd32fW3Yg12OEDzZfcXymi+G5B0mCina/2l0jQiAOqa5ehqLbDVUnscnHeQb+jsNBk5VAFySTdEJFxw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790093046; c=relaxed/relaxed;
	bh=dfrxig7zhSKDLhGOOvPoUHViJ6FfSwVsRqNPifKAURk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leGS4sLPqA02ZLWvGjSk4pKd0CU9fC82hlBW97mRUe7cajZSEqNfzoSUBjQVq/ueXDgTPZKYX8JWACCwZlrwgrUV8D8zIgPo7L6z5To331lS7bn4x3ROB6AcRNEFRZ280IJzCikO8dejw6U+K1CallHozN3DycahKEPth6VR9Rw6Zk0LnnmL6zwm9zB61Z0j4Kf96zlrzWWbPfAuGdFAYWKOvVPEasB5vxvvUjG70rLfXsZKrjjXwRosNFh9izy3MK5g+aHyZS5Px5hSjuocz9sNd3xtD8S0K4DNYv2ukUHzlGy2BNuk0DmPOHefKWtXXWd/460soiVxvJScbWyhXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayaMGQKZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayaMGQKZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com [IPv6:2607:f8b0:4864:41::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq4fD4LYMz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Sep 2026 02:04:03 +1000 (AEST)
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-67109935888so4406567d50.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 09:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790093040; cv=none;
        d=google.com; s=arc-20260327;
        b=Ar7D1qOIG6TePUMV0bpj4X4ndESr5g9LBIuXEuRZxiwyKc6h4WSepJJXfvt6rdGHNc
         0xCTWRPjkxjtkgOj8QGHZ2/lU0/KZOD78yVCnp8Yihs97hQ2tzL9sjSK98HzXr8Msmm9
         2BxWFTguKwU1HJPLpXnympyo8Rl3svldmwpV1x8tW/LNtWetTwTwm2L8cWxVMItZ6OHP
         Nqa0rW+bCnbcKTzTwUy8gUKI6vr4cbQtuR3PwK9qn8XRzLyJNkXD2BD2BXPXLC4XfnO5
         RLyIyZPkFzaEuE/7EHj69tsOZ+eLnGWM9BxX5II2tFmQnlK2KtLJ0zP1s6aXAloGEG+5
         GGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dfrxig7zhSKDLhGOOvPoUHViJ6FfSwVsRqNPifKAURk=;
        fh=vlOL6pn9+LrepCoAWlQFHKOKDNI5OcKQJ4WTkv4msOs=;
        b=j6HFTnzWZcKP1qIbIDgw9rz16XAC7CJcz0I2wprMYSiCz36KBorKqjJUyhbEQS/OTC
         gCDpSznwoklXDND9RgnlP66au/WrwEqT9loci9T1RfSfm2hZ/TQJHlbN2O1Wgnt42g22
         KCYunYaT88Ps09NgiT3jaypuv/rHlXqSqtYrcJFG7pueUpqirBO/8pTm5WS+70m3zvNI
         Qi9yS8kO2Qyy877eJXrLoypGnng4Fkmw3sBiEzGbZ0lRQj2NNb4sXnLBVaJ3/o61e3/b
         isfUuK4yVhZfRh+A2PvwokIRe4n8u2ie4t3b4lJ1wN7utSpbwGlS5Md7zsRGnAWf1FUP
         mYUA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093040; x=1790697840; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dfrxig7zhSKDLhGOOvPoUHViJ6FfSwVsRqNPifKAURk=;
        b=ayaMGQKZDSdUIBSiBDmBg6uM3B3pAJJIbzDT1lQSL9VH05hbx5ceSc2415BQVhEaDT
         iMynpl75/bLX7XjfGJDdCOdtY1ortbHrhSLJjFfBiCt3PeLq9CsYdK9LiFDenDlCm3J7
         a+YYC9Lob+CKAzEqxjmhn2AffOK0CTBc0hnV8sCCwNJQMKLRGl6wRsu5eOkqnBEIehrF
         252734jlheiz4PsYCQ7qPgLuu5IsVuwGlkyt7jyzCj7MUucvpYPXEvPNrhfcuWArrZID
         tRU/yTYrHIFpWywZ55YAz2QnvO4cpVUFOVn2y79x8i4GiDZDuuLpEIye9arNQFoiMBN+
         NShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093040; x=1790697840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfrxig7zhSKDLhGOOvPoUHViJ6FfSwVsRqNPifKAURk=;
        b=0w4wRFcChEwK3RM/EwCTOTxBUfmxf5pSNlJWkjzfP2R4EU7dxciiba2DbTCoJoAA4b
         tO2ymDRcNfBR4lzeK7GIhzfu6GpsL88aLT60D0Azr+WYFrBirmjHzW2pZi5PHQKmVerU
         nCCxoidIYZgqkm4GrvNQqNYAxsnhytbHFk5KBKOG7rQR273O+mXDuS5hcnS9jc9JGjSI
         tmGTANZKkI7teNdZvjdf1Y0tdxCO3GC1rlaEknG1raBTl3nQB5O3CGfs1RP37/v/iP6s
         9O/kjrXMNcEQebjgaHUKhRoYxr7lsWhUeEFUt623krMEXSBv4jdKBv60BGFiTf604Z8/
         ZEzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiKWImpIKO/30Oy3C8Zn24M+D5G3mZeVnbmg9F+Uc5beIadmSK1jdBjsOkvEQdW5S2d8XrCcAunInEzYE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kh0IZPSan2rYYWVNo4InaP7ac8lSNSLlTKOukNtE2uJRwDq0SP
	IY1Dj3cy3NjOI4keOHu+aV0NF11DVGjh7hWZqfSPg2o1D4/fBvrjJEPAyCYBC6uvAsxw9Eo2mO3
	C+GsEML09U6f5JE9Ls1OyUU/rIBYkr+k=
X-Gm-Gg: AYBFou2AS5U2T0mmZ+UOdSrFyQoG0xOT9eGkkeyCyS+nqtpFx3RET250Ni5zym29GoK
	A+GcmBSKqmGs4Gt3jZi0kjEbYQff59inxxLSncOLe2KDZSXognZ+fDBWNw0k5ls05bORTCeyUTV
	srES6MqPGkMGz+wltBYUrXRPH26sNzAjlKBg5w2K2cthc2/2yblCkbmMxs8m34gxb8y4hz0ET60
	peAvWtTzRaezfYXmpBOkvn11au+Djy8UKUh9eo+hQgt5VMhqdQ4wgvAolyiB6o1lPaAg9vBuv5K
	Q+OcnfQDqJyqtrDP9FwqhNVH24YdRDzQWTMsi9ncB8Q9TlgAqV1PvFKkREnFB7XmrwXi
X-Received: by 2002:a05:690e:1249:b0:671:502f:dd32 with SMTP id
 956f58d0204a3-6717fd6b6a6mr5447023d50.53.1790093039560; Tue, 22 Sep 2026
 09:03:59 -0700 (PDT)
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
Precedence: list
MIME-Version: 1.0
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
 <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>
 <179008369971.83584.9572254757332285883.b4-review@b4>
In-Reply-To: <179008369971.83584.9572254757332285883.b4-review@b4>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Tue, 22 Sep 2026 21:33:48 +0530
X-Gm-Features: AcwNN1Vb40B7-CxaHaopn8HdM12Pklcn_b9p8jPV7ixD3IPvviwFvarSvM72SF0
Message-ID: <CAMFFDGhNg7ogv0NYXe5Vga0Tf+XD85n80=MOwa6FgSX7q9D0ew@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Tan Siewert <tan.siewert@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, andrew@lunn.ch, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

Thank you for the review.

I have successfully rebuilt the B650D4U DTB using multi_v7_defconfig,
with CONFIG_ARCH_ASPEED=3Dy and CONFIG_MACH_ASPEED_G6=3Dy.

I'll correct the GPIOP indentation and retain the review trailers if
another revision is needed.

Thanks,
Prasanth

On Tue, Sep 22, 2026 at 6:58=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> > Add the device tree for the ASRock Rack B650D4U BMC, which is
> > based on the ASPEED AST2600 SoC.
> >
> > Describe the BMC memory, SPI NOR flash layout, UART console,
> > GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
> > connected to an RTL8211F Ethernet PHY.
> >
> > Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.
> >
> > Configure MAC0 to use the RTL8211F in RGMII-ID mode.
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> >
>
> *snip*
>
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> > new file mode 100644
> > index 000000000000..a4e384588a54
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
>
> *snip*
>
> > +&gpio0 {
> > +     gpio-line-names =3D
> > +             /* A0-A7 */     "","","","","","","","",
> > +             /* B0-B7 */     "","","","","","","","",
> > +             /* C0-C7 */     "","","","","","","","",
> > +             /* D0-D7 */     "","","","","","","","",
> > +             /* E0-E7 */     "","","","","","","","",
> > +             /* F0-F7 */     "","","","","","","","",
> > +             /* G0-G7 */     "","","","","","","","",
> > +             /* H0-H7 */     "","","","","","","","",
> > +             /* I0-I7 */     "","","","","","","","",
> > +             /* J0-J7 */     "","","","","","","","",
> > +             /* K0-K7 */     "","","","","","","","",
> > +             /* L0-L7 */     "","","","","","","","",
> > +             /* M0-M7 */     "","","","","","","","",
> > +             /* N0-N7 */     "","","","","","","","",
> > +             /* O0-O7 */     "","","","","","","","",
> > +             /* P0-P7 */     "button-reset-n","control-reset-n",
> > +             "button-power-n","control-power-n",
> > +             "button-nmi-n","control-nmi-n",
> > +             "","",
>
> Nit: indentation.
>
> Other than that:
>
> Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
>
> --
> Tan Siewert <tan.siewert@9elements.com>

