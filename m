Return-Path: <linux-aspeed+bounces-5039-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE30C982FA
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 13:26:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq18k6NBsz2yQJ;
	Tue, 22 Sep 2026 23:26:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::19" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790083606;
	cv=pass; b=QE1+R7aAbAUBpavtvj3d4ieQNBK/0ZUUBymKy/agF01R+dyO5mufemKcc8k7jJc7u8Q5fgx1LRDwtSgLJ99dMDB1Q8QrkL4M5R6RqhZMZ5qgbV+SM1d9iHUKylGbkHYBsyOAUlgdJUPcHhc+D5XB3N4dXh47cCo5iTr8KQ74fPgpS3GlKog2ojCon16sdIq7PZBRAoVYWDhpc01GDTqXqoYP9SFs4oSF7yIinJzqhfd7eWc0RBq+ucbwHd30EuX/D3p8JhWxwpoCKqocU8jHwIrrLk78FrldN1XlDmrV3jR8MvUVpMhmDhMmwmlKq1J0PKsk3hnFlzNzKux59Mspyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790083606; c=relaxed/relaxed;
	bh=KZk3ftFgsljw+yHRBP7QV66dcAilUaP73F6UAmO5w1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb4GAr7jSQg/1HXgysD7JltgmixOzZfoaijercAJPdd/6/EcDv0fa2PKKi7dMacHW68f4U+AgjBM6aaE6PkIhx8mzaTMd1/A0vrXhBOZk/50xnOXVa7HRst1dRRM14VPmNYs9CHS8yhKp01YB2BLmGKF2B25D55jVZOVEaZWLfuz3DTr5az3J/dwAkytOtH9/K8+pu+kUqio/3RFcKA/KHQlO+IP8fSMMsjWWB5Ebbg1RUlxoKJIzpiN6J+DmGqJ6/I1zOUvXNpGahkoVnB5YfTpIcdRbHNPEM8XDS/wtKJr7PySiD7y7retgaeD08ueAG2HCaAOsFjMecKp8dGXxA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a2jMjNrR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::19; helo=mail-yx2-x19.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a2jMjNrR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::19; helo=mail-yx2-x19.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x19.google.com (mail-yx2-x19.google.com [IPv6:2607:f8b0:4864:41::19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq18j4y0rz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 23:26:45 +1000 (AEST)
Received: by mail-yx2-x19.google.com with SMTP id 956f58d0204a3-66e4ab1b9f7so2109388d50.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 06:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790083603; cv=none;
        d=google.com; s=arc-20260327;
        b=Mr830WqgYptzJF6BDermGV2A/SlZLWYxnWTe4K3FA6tb5pfnb60G0er3hj4Hrk9/Sy
         RVb7YFbVnV72u67ypAm11Jn3InTuxMG15AaYClwmK/EqMETGDuTAg2VD5PVuzJohq8uV
         ligTxRmAAIvIQtKTKZ+HBWXglbaaZ8O9ntHm7kHHQ2X1ztuur4qBoCu80vIX+1d9fL6G
         whWTrQplboiW5AI/K8pjDSQxl3UrLBTM/r6t9WXq0HmYLVCbDb9xmwsEGNEpFa7ByPKb
         G8Gh0PjANxKXzt4Lg8+A3VGfrKKedEx77Htm2O/s4bnvUFgz0sK/oxp1yJaE/ByaN48b
         Cumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZk3ftFgsljw+yHRBP7QV66dcAilUaP73F6UAmO5w1Y=;
        fh=f7J+pmfuVlXZDEZtzC01Of7CyDhPjRBkmzxxI4B3Ifo=;
        b=cvj752MrdSBrxksMm9Hn+MP735fUhsXo6P5RssFNHbh/mKBdnrAbCDPRQerR9giVml
         p4pWKhtLprMOpkzzLSuH22PZOcQYw4MnAMrvaBS9cWP/seZGN00gbXOwou9FZbPL/FRd
         72WoEMIbpzLWedoFXO4iH02jqBNayUWWYGNkGlhh60eAyktIP/akBokOYQkjysKVmWuD
         N2gEW+nmlK6xVpE1eMOalqq6ICv/jF2M/eRkNKS0Z7N9XJFXbfw78/5S2jVDbTJ420sL
         A94uMG8UDa2IKD3en0/U+Jf+xf5SqjkFlh3IfSXipOkLUhaPkzI1Isl9bMvV46eHa9gL
         GX3Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790083603; x=1790688403; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KZk3ftFgsljw+yHRBP7QV66dcAilUaP73F6UAmO5w1Y=;
        b=a2jMjNrRbPK1KZX3kcstTalWGeM9cDc4F3Un4aIHKWdCwZ96naa01Cy2PK+5+uTeoM
         Y5+ynE2/DtVuYtK/bcDzB/i0x6zTmrWJXdZ9qIcXnPhINfMewFrycLdeXUTBDOxIdbNK
         vLWh+zarPjkpKa7r6eewQfRRTVyTMAuHRCbXoWjyW+LllDe6DRtCjLk7AACjrqFpmUS1
         mYj37tno60PPZ+NRpDBSPDa3VkfcfcalzoBL8o5sE4PMBXk2eQ/yoDbvHx2hju3f3Ca0
         E8V43WsLFiA7P50ZqeQrbjBRmoSFq8EeIBkJW0bjsxQfrPVD5TwwOnrnfw9ultGBcje0
         LC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083603; x=1790688403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZk3ftFgsljw+yHRBP7QV66dcAilUaP73F6UAmO5w1Y=;
        b=ILGrPkXie7K0doThJ9JFBR5TL4nQltjxRRyK7izCHksj1EnDSHcBeO2mtYEgADGN22
         QGrpsKKLHvj/sedywU3AmjPZEVuIw1A8s/1Q34i2LTXDCGBE5tDm+5vaDNcx/Rau5DeA
         gqajaXlp1Rc2FBnof8nb5jNRUkD2Xt0CLApPttHENeWpH+GHmTyRZTlkGhB+cLvuY1vR
         maZKCo7Vei1tWLCctupItd6BtLPM+fMxywqk3j/rQ+vwtSso6rLTG1er1A4+GffNlgVt
         chUCyA2S76MJQeAEK90UC8AxabrgFlPQ6Qj9rx2pJuWOPGqdadbsPHNDf3h4lZjvrFWe
         HVuA==
X-Forwarded-Encrypted: i=1; AKwUvBzVEIaxl+SYBpxtSTlDs86dXQqrt7PBBWVIZiphNJlQay0Ged9XDCG6BZq8OBV0nWluMUDqfAM9DhGinm0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l3iWSvSVsyLvXMTYw8DbVhF1Y+SztCZPCNRvLnaaVP02mjNZTN
	hEtrnBRrg/SK6wvwZ3/S6lpEhjp0PiO08tJJQz+/TWUbBrLPJhWLenvTE8o+LtMXGWBbTUNyH0e
	mLAPlbHJbYNPXOuQf96DDoYVnTSEkBK8=
X-Gm-Gg: AYBFou2wLhCs4uTwU40JvVziym0LjOjb+gtRBGd95VVzhj9UCnH8eEwBsk1v6KyCIlJ
	vxEdskRWDgRl+aY10ytbKjYgc/1ElxcnOdWELsX+PT+C4Naf9N3NZQZ5MSGWunNlXuLW979fXN4
	oCYZrHz/vK/nRGbTb2zPEocA+qcGQ1/SIE9SIVi4DajX3UIRtPCLOQ8f+24YFHAqutR42akb8dM
	8kxEh3D9GPpoN4erjd4TOC2d/6M+nR+gX1hzUhBCVJX+1VGhjhv9LzwrhVwt+98HAj1JAuXjysg
	Y6OkuYoTPHyQ2AxcleYVNgZQL2EM0Qkhkjjxug2r0lrdYU4SyEk6DQ5VqiML+0C4nRdhuQ==
X-Received: by 2002:a05:690e:144e:b0:671:4e37:a832 with SMTP id
 956f58d0204a3-672c2a1492amr1424683d50.22.1790083602711; Tue, 22 Sep 2026
 06:26:42 -0700 (PDT)
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
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com> <8cb38ff6-1210-4c5a-b0bc-b0b50dd2b9aa@9elements.com>
In-Reply-To: <8cb38ff6-1210-4c5a-b0bc-b0b50dd2b9aa@9elements.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Tue, 22 Sep 2026 18:56:31 +0530
X-Gm-Features: AcwNN1XaRXA3PPjiOAu8sy9beqIj3WvHMknSJQK0T_ZOITGdCWmSpx7UdDH1Lq4
Message-ID: <CAMFFDGjJcmpaQYHe=F+jpstbdk9-uXPKkBxLkJqAJRiyyTkBvg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC support
To: Tan Siewert <tan.siewert@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, andrew@lunn.ch, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

Thank you for catching these issues.

You're correct about the defconfig. I used `aspeed_g5_defconfig` for
the DTB build and incorrectly reported it as validation for the
AST2600. I'll rebuild using the appropriate AST2600 configuration and
correct the statement in the next revision.

I'll also carry forward Andrew's Reviewed-by trailer for the unchanged
MAC0 and MDIO nodes, preserving the scope of his review.

Thanks,
Prasanth

On Tue, Sep 22, 2026 at 6:51=E2=80=AFPM Tan Siewert <tan.siewert@9elements.=
com> wrote:
>
> On 9/22/26 2:34 PM, Prasanth Kumar Padarthi wrote:
> > Add support for the ASRock Rack B650D4U BMC, based on the ASPEED AST260=
0 SoC.
> >
> > The series adds the board compatible string and describes the BMC memor=
y, SPI NOR flash layout, UART console, GPIO line names, graphics reserved m=
emory, I2C EEPROM, and MAC0 connected to an RTL8211F Ethernet PHY.
> >
> > MAC0 obtains its MAC address from the EEPROM on I2C7 and uses RGMII-ID =
mode.
> >
> > Changes in v7:
> >
> > * Correct the GPIOP bank line names for the reset, power and NMI button=
/control signals according to the confirmed board mapping.
> > * Remove the obsolete GPIOF5 reset-button line name.
> > * Leave the binding patch unchanged.
> >
> > The B650D4U DTB builds successfully using aspeed_g5_defconfig.
>
> What? The B650D4U has an AST2600, so using `aspeed_g5_defconfig` means
> you're using a config set for the AST2*5*00...
>
> Also, please preserve the trailers from previous serieses (i.e. Andrew's
> Reviewed-by trailer) if you don't change anything significantly for the
> parts that got reviewed.
>
> Tan

