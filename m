Return-Path: <linux-aspeed+bounces-4305-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF0CDB47F
	for <linux-aspeed@archiver.kernel.org>; Thu, 25 Jun 2026 05:34:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gm6tX2Z3mz2xwH;
	Thu, 25 Jun 2026 15:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::12c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782365652;
	cv=pass; b=PBwzCOG44Op3KZ2pdcVGQFEmNUj5tsiOS+fcpnGZ/yhQ9BNDGV55eUS6tX/4XERUIHz5A+wg6wQmzcynNoiojNxa7MjsOP4PYsXkGDT9Un9w+to+590DnYZhiZRze3TYqXfIrKXRbizlF0Yz2hDeXs+JsXrM/r8vZwQI10ViNKWeOFaAOwwMF9RTJnmPPg1aJ81KC+lfOnS7E7tmJzZcYeySajFAi7MF74RdNuBzY5xX8EYmyLrNrL5XN79Kgm9fYtWM3qyTKVUKk6zxyvmVHynPkmpQkOoOdj4AnKTRql/U/fd6x5M718LEbMUxsgORyoL2uzEYe45Kk+RBWAgJSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782365652; c=relaxed/relaxed;
	bh=A+9zdrnWdYPYO0YMlgRGb3kLO0yAknKaNgGna5hHFMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZs+vKaD7mFk4OaUv1IRa17XBmYVVJ7Kr86DMDK+TKtLBUPVOoZZ8mCh2tGdiFv9mq6kyA6TkR1UjqdszC8fQRhoVgkAT7jFnnPLzNvLCX0wSgkxbLIpJCyiFeHZMMH2IERO8KjYJBafEtKEyXcuQ/MBZTxvVr6clFS6WsvyoI/b+JnFEbkUYAjzYFbKzNAqpi0BqAorRrnt5jZ8Asmzmes9U8eMIf9d6Ugen+j3CkePzYUYlqThbUWF8lP1AG1eyC6QYhkl2jZctK29vsEcmlSa6QhaqSqoQjiX0tcoWrzGEeLOsbBgV3ioBpr46v3QXQt6ss/yOEOUjDZv6CEz2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOxwMWxq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOxwMWxq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gm6tV30KYz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Jun 2026 15:34:09 +1000 (AEST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5aa68cf9123so1959781e87.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 22:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782365641; cv=none;
        d=google.com; s=arc-20260327;
        b=muBkRgXCnrnMnCgJdrXZ/axFWaHkwjQu2eijEUfC1SWLisGmrY81QdLzC6oYANTFef
         5Y8EL+qPPOi1roSRLJdXAsg+ZUqAbkQT440I4Foe9PfCGhoxHdmSAKCkMHA4mMoVKTXW
         T95bq1rOinVdCKx2oPdh5JodL11dC98X7CJWQiC2GCZOyhZSrpScRlH2cKe8n2w1JnYr
         sTjAqUUWNaaKLxbqVXm5XQOyDMvnLaIDjsGer4Ue1iDosZFjIO37uoy9rnnYLYbQpZf8
         JOuHEiPu6OI8Wxfr8sSIRVlu66XB/apohUl1Up0R+lC8XNTgteJ8xsbTnWaYmpEaB+Fw
         1qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+9zdrnWdYPYO0YMlgRGb3kLO0yAknKaNgGna5hHFMo=;
        fh=kXi+MiF2REb0yqgrNLev6fx23t95AizfXSdhJrKtQkw=;
        b=JcECzcSos8kgWRdXLf1cXsm6YsZSxsHrv6asycDvTi2J2hXDcTAg/Qa7Db3D4I3JKC
         TDlaboxkJWDBKoGYRkJFzr1BpLE7QS75JkvpJFZLBFqW/0xOn4U8HmNvKcfaE96fzRVZ
         xeolK5kurG+m4HPMqW9+oZF+ODAihUx5OvgMEzYMw0bMky+hXJOZ8zq94S55dq5NJf9i
         tTdoVSMtRut3BztCGA63li/SlTonHRqyurbLi3mZOSamDvW+yoSRSmQLrok6GI6Pazog
         Guo7hVH1wjJ1AY8+UzYfC7lV8xYhRQPlCyF45CtgN3hHw7qZkC6HSD2WEiXSomRqitu5
         cx/A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782365641; x=1782970441; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+9zdrnWdYPYO0YMlgRGb3kLO0yAknKaNgGna5hHFMo=;
        b=LOxwMWxqkHpnhnUZYAujT3l3X6zwzHBiKfhPLdfCIyqBbqTwjqXROjsZNHgjoqYpVJ
         dnx+TGwcQV/MsYH7EWbmItyTOjwLe/xlTxSmexRXFQBzsIGi07QDkqnaqnrI3I0duHhR
         ccLPGu8rJ1OcLc/8xs4QeSOwoAYWA4ud0iZcNG/npTl8oxsWeZf7O3vx24LVF9Leg/1d
         zZYoi/vuijza1FQN5rHJEEyRJgM8lihKqGlR0wqAgoFg2dXkRnatUB95KxD+xH056S4Z
         4omNgCIA265uwmYyv6Y+Q3oQZny1dENZOITJFbtZPkkwLk47UD+kWjQgeAU5oZJyXjlF
         gCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782365641; x=1782970441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+9zdrnWdYPYO0YMlgRGb3kLO0yAknKaNgGna5hHFMo=;
        b=lXKmN+WHfm0K9ZA07npFwt/fc6J15rmYUus/8hXnQAi/czQo6+/URtVP+jEY5DwYKp
         d82jwO7UkTLUaIFuwvFjkqACrMVBDsO42XfPfjVEnvlrCE9HSwCMIkGIowRosh7YNIbp
         YzQZe3YdWEXHnnHCpxn9S/kcTpszZpA4jab48sQLc/38hK5nsHWNk0JxBL8w4kQFVv5g
         5hVRZ6aaALCtjDSS3OmUZ/kNlQlEbZD7z0BDfljLl7bjA28aABAqhndjtHXxq7gWQ4Od
         AME6s2VXepgT/ZNFygf52lBGC5SjNuHBSMn0nSV/nmquhUC5HELAV1bLgWTZDzUlocdt
         RaXg==
X-Forwarded-Encrypted: i=1; AHgh+RqHwMdjOL/iWpVaxMZUQ5UPhkKP0+PD8Bjzgb20uWai5R9MGOC+uKS60Jl+wI7d5P1gg0QA9jplYWqlrjc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPYxAWfoNTgF+GCvfepdUPpjRb/ZvcvpE3OhpsHi43Tm+4DHlM
	AWg5O+kvRqlewLfgpbc7VaeudrC5r+IUSo1E6L6gyr7ZQaPE5Ectxu4X31nTHHzjM3u2+OXe26E
	qao6pUtm5Ekl6GzxU3IbuWXPVUnUauZc=
X-Gm-Gg: AfdE7cmOX3cO5FWUsM+mZuEODqLvqf47OxIRn8qJgbSBgx9g3qE79bUvurnKPe5TjyL
	y2alWeTqVaOPXfuZW3KLDDYCd2tvxVImq7sy+RbKnOXu5giSXry+HGfOPqjSJbRGjeY5+isPHzD
	SXdRCbIFt3Nm8ydO2waGLG5965bS3JCBs+jnzux1vD1bnsXT/g2hKIhQXiT3paW9/1pXocQEzIQ
	k9ikWH/tauk2BFgAro8sJnxFELESOcIw1dPzMIamQQWKp6TPHHgzoi8tvNAwKr0bl/aFYNdMg==
X-Received: by 2002:a05:6512:2c86:b0:5ae:a348:1292 with SMTP id
 2adb3069b0e04-5aea34815d2mr45473e87.38.1782365640650; Wed, 24 Jun 2026
 22:34:00 -0700 (PDT)
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
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
In-Reply-To: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Thu, 25 Jun 2026 13:35:37 +0800
X-Gm-Features: AVVi8CcTmMqcRiP9802pZDxyIJzSjqDj0HrKRWQTIvD6r3wqR2s-_IKZO7UmEjM
Message-ID: <CAF7HswP25GXigSqL+bGBz=0=RST2XjS7fNmkKcsy-qjxfg_1jQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maintainers,

Just a gentle ping on this v8 series.
All review comments from the previous versions have been addressed.
Please let me know if there is anything else needed for this to be
applied.

Thanks,
Kyle

On Mon, Jun 15, 2026 at 10:44=E2=80=AFAM Kyle Hsieh <kylehsieh1995@gmail.co=
m> wrote:
>
> Summary:
> Add linux device tree entry related to Meta(Facebook) ventura2.
> specific devices connected to BMC(AST2600) SoC.
>
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> Changes in v8:
> - Addressed review comments from Andrew Lunn:
>   * Added a detailed comment to the Marvell 88E6393X EEPROM node to clari=
fy its hardware I2C multiplexer isolation and out-of-band firmware update m=
echanism, explaining why there is no concurrent access or multi-master scen=
ario.
> - Link to v7: https://lore.kernel.org/r/20260611-ventura2_initial_dts-v7-=
0-a61d8902bc5f@gmail.com
>
> Changes in v7:
> - Updated the commit message to include a detailed description of the Ven=
tura2 platform's purpose and its key hardware features.
> - Fix comments from Andrew Jeffery:
>   * Ensured consistent blank lines to separate child nodes from parent pr=
operties and from each other throughout the DTS.
>   * Sorted fan nodes in ascending order.
>   * Replaced '//' comments with '/* */' block comments.
> - Fix feedback from Sashiko AI:
>   * Added 'idle-state =3D <6>;' to the PCA9548 mux on i2c4.
> - Link to v6: https://lore.kernel.org/r/20260610-ventura2_initial_dts-v6-=
0-375d8e9d7ebf@gmail.com
>
> Changes in v6:
> - Addressed automated feedback from Sashiko bot:
>   * Clarified comments that io_expander0 and io_expander8 physically shar=
e the same interrupt line (Wired-OR) by hardware design.
>   * Removed leading zeros from unit addresses in DAC nodes (dac@c, dac@e,=
 dac@f).
>   * Removed unused properties from the adc@48 node.
> - Link to v5: https://lore.kernel.org/r/20260608-ventura2_initial_dts-v5-=
0-37ee5bcf58b6@gmail.com
>
> Changes in v5:
> - Addressed review comments:
>   * Added comments explaining the necessity of 'legacy_' prefixes (hardwa=
re label collision), pre-allocated I2C aliases (future expansions), and the=
 'ledd1' naming convention (schematic alignment).
>   * Removed the empty `&mdio0` node to comply with upstream networking su=
bsystem guidelines.
>   * Removed the redundant `&peci0` node.
>   * Sorted `&kcs3` and `&lpc_ctrl` nodes in strict alphabetical order.
> - Hardware/DT alignment updates:
>   * Removed unpopulated sensors (adi,adt7461, infineon,tda38640, ti,ina23=
0, ti,ina238) to accurately reflect the current board population.
>   * Added the secondary flash node (flash@1 labeled "e810") under the &sp=
i2 bus.
> - Link to v4: https://lore.kernel.org/r/20260424-ventura2_initial_dts-v4-=
0-806b00ea4314@gmail.com
>
> Changes in v4:
> - Fixed capitalization: "ventura2" -> "Ventura2".
> - Reordered I2C child nodes in ascending order of unit addresses.
> - Enable PECI, LPC control, and KCS3 interfaces for host communication.
> - Configure MCTP controller on I2C4 and enable MCTP support for specific =
mux channels.
> - Add Infineon TDA38640 and TI INA230 power monitor nodes.
> - GPIO and Pinmux cleanup for PVT:
>     - Aligned gpio-line-names as requested.
>     - Remove unused or non-existent GPIO line names to align with Ventura=
2 PVT.
>     - Update specific GPIO pins to empty strings where signals were remov=
ed or consolidated.
> - Adjust SGPIOM frequency to 200kHz and update signal line names.
> - Enable UART3 and add serial2 alias.
> - Link to v3: https://lore.kernel.org/r/20260113-ventura2_initial_dts-v3-=
0-2dbfda6a5b47@gmail.com
>
> Changes in v3:
> - Add annotation for marvel 88e6393x
> - Modify the gpio-line-name
> - Modify the node order alphabetically
> - Modify dt-bindings document for rmc instead of bmc
> - Move the gpio-line-names to original node
> - Link to v2: https://lore.kernel.org/r/20251224-ventura2_initial_dts-v2-=
0-f193ba5d4073@gmail.com
>
> Changes in v2:
> - Remove unused mdio
> - Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-=
0-1f06166c78a3@gmail.com
>
> ---
> Kyle Hsieh (2):
>       dt-bindings: arm: aspeed: add Meta ventura2 board
>       ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
>
>  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
>  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
>  .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2903 ++++++++++++++=
++++++
>  3 files changed, 2905 insertions(+)
> ---
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> change-id: 20251222-ventura2_initial_dts-909b3277d665
>
> Best regards,
> --
> Kyle Hsieh <kylehsieh1995@gmail.com>
>

