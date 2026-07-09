Return-Path: <linux-aspeed+bounces-4453-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CAFC43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jul 2026 23:28:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxB406kkcz2yYq;
	Fri, 10 Jul 2026 09:28:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783606898;
	cv=pass; b=FhRZEAfzBEbYYf9UXLXqhbD58A/YTtyntl/MBcyaJD3s1ZOnAqxwovCalXEmts9PrBU0jw4umAxg326HlPgH7Kt33U5wDrE3QlBKZoSgPvAHCsu/qiIMsWwjVNGNtbkJtbo9qL9ErykS8PvAc/DFb1Vp6Ph6NPajWCaMVDcONWTppX3sunoG74wg5IHhVKO7/SO7PF8va8R4x2Gfh5zDLPe0hD4NhNvSRAVDEOCD2DjgEIl0GXVJVA829YKxg1H61CynvPoxRV1Ii7pwK5owq295STMJ6fMpTG2AHsQtKRTdXJsb56Pe3aGYlZar0IRSfiyIHA1ZUeSowakIw9JGJg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783606898; c=relaxed/relaxed;
	bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov6cvoPd2rlx5jKVk1wlAZdNWwlsxDWKJxFOB9YJdFjvmUX8ofuJixLE2iknhYtpSNBn0UDYdrxfz5NvxhLOdS5qrMwobmbL9ErIKQJUyTL5qFNCRhrvHxzE+bieZc9+nJb3ixiFImL0XKK2TRquklNmgfQQtyXA7FN51BHRBQ8onslAgKpBWX140T4XzLIe9DgCsQrcoeC97oG1vvBphYgzcukNoodGYbU6PWKk7mGKRul2orcsUQk8nfEOYo0fT3aKgED05k4WsjTDXBVhg8XRddoQVFvVlLLkx4qopeRMA7ejVLLMbgS8tjHrVBMJGhxwJdKep2GbG/vsYo7Llw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Ure1eAzW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Ure1eAzW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwxwc1nrQz3c9k
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jul 2026 00:21:35 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso1167572f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Jul 2026 07:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783606892; cv=none;
        d=google.com; s=arc-20260327;
        b=Rq0Of5P3o5Gl2919NOc42YT64VKnOv7s5OlO3m5Gcq4vv5CeLRHYchZF2UZNxJ10bE
         KFybJA+oIfKXAayzAirSv01TpasjFYDEkLtuQfLo0PGISQ1a6TjeOQmAoIsI4JnKT6QQ
         SflcYMuBOEFZfLETZizMZnTQn+FdWOI21mgJJi77Fd4vS2he5gg40RLhdWsWfZNlNJdA
         33gVFB4Q1AZ7W9CH7rGIq8ESrWJXJV6w6wvWu9a5s6Dt7arUXD6Cr4d4w+SYLvUtsuys
         mVBXJo/oXkHimRHvIqL4d5uClbvLDZrpnGltHyO229ifRGb/BQMj+Nm9n0pID3Q1HUid
         aerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        fh=ikae7IVfIngiKQpKCTTpNra8WoOB3gKaLXpa2OtbLSo=;
        b=rDj3dZ5kF4rGyN7kLW7N/7KELHL4F1dZr0uNlql+k6hgTm3zmYXCzwZvgm1w4rli3Y
         bisLnCAndKp+N5jr8zoqL+qio+XrnxcuoPTmltZ11BNdemOnvbkUC3OxCOsQ99Pyfnzo
         5xnjHP0Wgv475t/j4R+w81fsk0fIUDSX36Q11RmGZFVMh0lMcPlzKiqjUJQ09OxfVJse
         GX+LeBLLdxlUfv0mDxo+S2rWTFeO4od4TfexzP8jOB2SipFij1bm9cUTHj8a4Jq1/54I
         ROQ5iZRodihXnX2hBVPS7F7roShHs1Ifzu3ed9tdStmCpptj4gzLWln9GaGMRK2pFjVE
         rwqg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783606892; x=1784211692; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        b=Ure1eAzW5U2wARw1MjvfL/GAfsdrIt7zW6ZUd7FjPwloNqgZtsJy0IZv2ld9BhZ0aY
         Bjk+sjE+TdyVUx9OpEI9vBCDSxji/JPLOmFO/p7feqh1dmDH15e0JZwPN2O2QQNDPtQf
         CfoOrh3DkXPp28Nh68rPZn8KZVzMmAYPCnCousIN+wq5k+ghXs3h4oYlZqcxDdRzu2To
         RXNm92lBjrG4MhlfDMuGRNhtyRfBFeZUtn8rojFMQadZvYBjN5jpHCP1aAQzpUVbB+PV
         IGpESEGwNiFNCGPZuAEmvHNOrXZSTi8FOrQ0sMwnPLYcWgm95olaRmirJZHoiZRQ3q8h
         9Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783606892; x=1784211692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJC4lX0tZTp50J0S7on2pHdgb/jZHm/OiyTuKIg2KPY=;
        b=F7ozYhbV4gloOSgJqfEI8SdJTloReILoS/Sj/Uj2Qsmx2P/eY9hIVf6+vmsDaISEHm
         exBoaE9XzmXWB94cL8OS07y5xBlZ9qDjanuTPUCrmT5ILm5IwLeG09StGS+R5y8XI1es
         XUHv9NhBFJ9DtWlV6lodHe+jz0q+QvvPVlywXUZlCIV0T8febbSaG3DRBNcTYMmujonO
         NhvjAfGZx7xJKPb0Mrd4z5/OiBzOLbDtlWuwaEZhlKfpHteBdOH+A4SY5A0GlOIT9nD1
         aG0ug/MrPSr3LSfJfW8/Cb+GOd1ZrLH+qeLMPctrYPBkR82D8LgyFs94GAi8g5Vxe6tm
         15pQ==
X-Forwarded-Encrypted: i=1; AHgh+RohRjzpknriTHrHIVCu9wG3AXfYqqy4jCldTJSnyKZsOR9yelcnjUZD6orMhUh4hM3QIfPWb0lp6wCC3ys=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyH0/Olixw/zewusJCc4jyGc/pMK4+oy1rzCh7ySbBtr9B4uCgX
	6UoSrObmoY8YCwWYshq9vwlebfmIkkVVGE5zhLdHKKE7h+/ON0hRevWbGQHTGxra4mg75bjiPub
	fJKccAUSqUkQMIlLFYGJP4y7f3u6FMadyPxBuW9xLRw==
X-Gm-Gg: AfdE7cldlB6EDf4pMBn9U3tFeJRVxrZo7SoTwK/MXswyMkB2RFm8XNATmOfnXnw57GD
	ARraNVCwyVympyI2ldJXKv8aXT5IIeR4jn0ukBR8nxuepcag2pSEq68tBkFrlf/LUwtNw354ZzR
	0L5fjVDr6kDXQnYfxf4eP16fMNhorb/uE2H9mMTgNdBSBD2XL3h35GrWL1a17kxxSWMyNtfSBqn
	gnSei9Bv51Kondf9AKHNRwMYm1QyeCkYDajhB9BNvGx6tipFMymkYjNjxCl0C8wR0lksnHnxj2X
	4LSojL3K0+BtoMcNZuD5hpAm/nmABAg1waOS0lOzwZKDQxhBemmcNUpIev517zgdFOzj
X-Received: by 2002:a05:6000:25c7:b0:477:3986:9b54 with SMTP id
 ffacd0b85a97d-47df07390e5mr7576513f8f.20.1783606891990; Thu, 09 Jul 2026
 07:21:31 -0700 (PDT)
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
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <cbe59dfba231dcd55fa86233dc076b017d67463a.1783524645.git.gregoire.layet@9elements.com>
 <20260709-convivial-classy-mouse-db0b2d@quoll>
In-Reply-To: <20260709-convivial-classy-mouse-db0b2d@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 9 Jul 2026 16:21:19 +0200
X-Gm-Features: AUfX_mxl9lcJsse3vhAYFsJh4Ndo0WrxC586WRK2sT65vAOI74m33ywGfCLJYeM
Message-ID: <CAFi2wKYXVoBRHOCgA_6F20F2Wm4Z2wVz19+XRE9dH=gP3X+i_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, 9 Jul 2026 at 10:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Jul 08, 2026 at 03:35:53PM +0000, Gr=C3=A9goire Layet wrote:
> > The ast2600 was using the ast2500 vuart compatible string.
> > Make it possible to have ast2600-specific properties.
>
> Then add these properties here as well. Adding a new device is one
> commit: its compatible and its properties.

I thought it was necessary to split the two. I will squash the two
dt-bindings commits for the next revision.

> >    aspeed,sirq-polarity-sense:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      description: |
> > -      Phandle to aspeed,ast2500-scu compatible syscon alongside regist=
er
> > -      offset and bit number to identify how the SIRQ polarity should b=
e
> > -      configured. One possible data source is the LPC/eSPI mode bit. O=
nly
> > -      applicable to aspeed,ast2500-vuart.
> > +      Phandle to aspeed,ast2500-scu or aspeed,ast2600-scu compatible s=
yscon
>
> This is a deprecated property, so it cannot apply to a new device -
> aspeed,ast2600-vuart. You cannot use deprecated code for new bindings or
> device support.

True, I'll remove it.

Regards,
Gr=C3=A9goire

