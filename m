Return-Path: <linux-aspeed+bounces-5041-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F4C982FF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 13:28:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq1Br2rXHz2yQJ;
	Tue, 22 Sep 2026 23:28:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790083716;
	cv=none; b=OMNTGMpTldX70kg72Ly5rNv7yHAU/fKiEqJgXl3iDYr0f0nqnNU4Vho/ZBvDPVF1B/PYkYiY7c9hFIHtl8x67L6JbUg96tm6OuslkgZDH6QPf1kaTH1y3rLbnjhqNm5tyx5ey9FbXSjozOIDXBmUhp0X0c8TZy6PWVq2/DyqOxly6VpZaYWZyvFLt577h6UXmYr+SrZPE4hYbxB0GaJAd2wXwb5Tm8D+IW8wJg2oPAM0vl+B1rzwRDG8UstSYcc/U6rXfQ1IR8v843Chosw3SBT2bz7D7BazXvbcL6ohGQkpBK+n4CmAND1qotJK5+bcNb8edc4jIHRNx5fN46LKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790083716; c=relaxed/relaxed;
	bh=lZNjlC/+ZO9O6oGCVqCRDGRskcv8+56l0c98g5Ml19Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DgsBOkInguN0e9KIfShUu//ARdmhKxajnw9s8z6bTOpLu1HphbuQVBWx6fo/hVI2thsW6QQF1TGIputZP+m7kmBp/aSwDsOPzPjw8P27N4qDFgZQcgAnNnTDLv6hdHmc2YnFVe43Eb8iCDLvtgIO0IyP5PCfENSE3xfxv8VPqvzPLWYZgdQ0pSGoEYoS594zidQjyBi3kO/0IsxNkOW5HFveYEuHdKFYPO0cIniwE5xyxkn4XdYJgkEf7F4iAT9h+XAgEIAHqqk1ZThZ75aY+2nbALXUSf6kQTvzyJUXhFbkfiWRcDlVGMOPXezfHNrYceQuASa/ovj3G0ZnMvugeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=I7BMZROS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=I7BMZROS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq1Bq2VCnz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 23:28:35 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so24463405e9.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1790083712; x=1790688512; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lZNjlC/+ZO9O6oGCVqCRDGRskcv8+56l0c98g5Ml19Y=;
        b=I7BMZROS0DXFvJ+RKEZq9NrghRTZO91kxDa/5r2Ma4nEp1bJc4d0BdusoC1snyY6v0
         D3n4zsWDbU58Hp0B1e0+vLyEc0qXPrJtpjYaM08EQlxVm7L8lVfutIrbhchtwjJ7OxIM
         gAtZA50AVbFfyITzoxl6gw8WVWqyeICoGYJ+JrLMWQpdEucWwo/AYMVWTM2eKmQqHkNn
         Vy3F3MNjaxAIXprt4hHZpHf/f2C3OESGSxm+M+gnjaL3M70Rk11wJ1kzIJOHuN1TCtRV
         1sL7/yxOUsd2AVRNJdEw6Lae0xBm4eD3wT6Y/hZlo3W3X9TAuWj7aN8U45CZbVa31CRq
         GOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083712; x=1790688512;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZNjlC/+ZO9O6oGCVqCRDGRskcv8+56l0c98g5Ml19Y=;
        b=hAzaIAlncWuzWx+4DL2gzDIMe2JBqmVsLvSHlKwFlBEPNpzBt9cwprFyogaXL5b/lF
         PWtlUzXpuW7C7J2FklI0n9Fe0BqY1NUwGyeaD9aqW74VDVXG1cslAOmLOLf1HDdkJq9i
         rQ0ggRst9OfSOcrdoCEVNEaFij76+1OEoKlp4I6u+sdbZxk0dhLliuSWP4vb1970tjyT
         M2ecrxF1EHfxgBungC/dnwiaq7NTKzG1qwtwEYOAc0dtqNsDOzdsrQ2A3HUYuO62Db0u
         G00CkHtOrIfWTj9MmuvGz8NqjcRkOuGbmNqBrula0ORDmDALB7kEfZDINWA9AUMqj6n6
         kIOg==
X-Forwarded-Encrypted: i=1; AKwUvByrIVjpjTYkyQPxFcj9d48CZTbsi5MYX/PQX2hMjxpJo+kRHwmQho1Belp/NAtG27vwZZ1XlDvhgQPO9Ms=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mmZvseBS0bOI/ZTFFk+VVZr55kBgMObX5rvbu7WRJ90y35NgZp
	6IJsDXyNqGP/Cm3bi1Dq351o+ZTM1BZIPSUq++h8/crv6JWWtF9r+hdwocGI3MGydGw=
X-Gm-Gg: AYBFou2eelrquBqJLMHlcADBdr5CcJ6eMmST6KnxOV0ausXPS64of7PR+KKuvVhahq1
	Pjx7oH6TElCdojc9yhSuChUmIElzt1NDnDHo1yMyFQwhuVHO8ZhkpEnHXZRHJeq5hpJoJChVxYV
	fgcjp8ZN9YYZaUXwqNvpbObihzmuhzIzTJaQ3iQf1uWlvOLIWDqGZdo94tDcE8ANmO8MD4B+7Ph
	i/WK7cKAO5UZyqe4e48T5vNNKxaDO8DnEJVEpEV06dHOizd2hfyoM6yYtzE0qeo58NnKB7LztY+
	cd+vo2VnwW/uF5NSCCrkAY8zhaUC4QZTu4xgelSMYBANmDw752HI6ECwDOBRwXAyiMCmRkabELz
	vkOhqHdcEOllaMH20saZKAh3S8tQ7OKLEmI45e9YdTke6SlQgpEbJN2ZNWS7qQkfu4XG33e7DEA
	4DpKw3llSXTPsn2mEC0am9UJ5fLuohB5BG0IXICpeGoy8HV+lftflpnsLuKwoCpbZ7GshJG8cxp
	4hSC8PC6b2EK6k=
X-Received: by 2002:a05:600c:314a:b0:49f:ce73:7aa with SMTP id 5b1f17b1804b1-49fce730865mr142999245e9.35.1790083712062;
        Tue, 22 Sep 2026 06:28:32 -0700 (PDT)
Received: from white-mocha.local ([2a01:599:842:c46f:7b1d:31f2:7a17:2f4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce2623sm98226175e9.13.2026.09.22.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:28:30 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
From: Tan Siewert <tan.siewert@9elements.com>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com, 
 billy_tsai@aspeedtech.com, andrew@lunn.ch, tan.siewert@9elements.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
 <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>
Date: Tue, 22 Sep 2026 15:28:19 +0200
Message-Id: <179008369971.83584.9572254757332285883.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790083701; l=1759;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=xCUiIr5EskgNmS8vCVmRU0QGH9yOZ9MWRCiiIOcxeqo=;
 b=ULILOtcbZnS4GYuH+KUA3n6tP0aNNnEcrdkLC88RnSQcm8yJEzrtKY85Upx9eCV9NuLq05VSE
 ISHdQHepC1gB+65oLajN7pZjrTmD2SUiJrvhRvKx2j57FFgFm8qPNJC
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add the device tree for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> Describe the BMC memory, SPI NOR flash layout, UART console,
> GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
> connected to an RTL8211F Ethernet PHY.
> 
> Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.
> 
> Configure MAC0 to use the RTL8211F in RGMII-ID mode.
> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
>

*snip*

> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> new file mode 100644
> index 000000000000..a4e384588a54
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

*snip*

> +&gpio0 {
> +	gpio-line-names =
> +		/* A0-A7 */	"","","","","","","","",
> +		/* B0-B7 */	"","","","","","","","",
> +		/* C0-C7 */	"","","","","","","","",
> +		/* D0-D7 */	"","","","","","","","",
> +		/* E0-E7 */	"","","","","","","","",
> +		/* F0-F7 */	"","","","","","","","",
> +		/* G0-G7 */	"","","","","","","","",
> +		/* H0-H7 */	"","","","","","","","",
> +		/* I0-I7 */	"","","","","","","","",
> +		/* J0-J7 */	"","","","","","","","",
> +		/* K0-K7 */	"","","","","","","","",
> +		/* L0-L7 */	"","","","","","","","",
> +		/* M0-M7 */	"","","","","","","","",
> +		/* N0-N7 */	"","","","","","","","",
> +		/* O0-O7 */	"","","","","","","","",
> +		/* P0-P7 */	"button-reset-n","control-reset-n",
> +		"button-power-n","control-power-n",
> +		"button-nmi-n","control-nmi-n",
> +		"","",

Nit: indentation.

Other than that:

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>

