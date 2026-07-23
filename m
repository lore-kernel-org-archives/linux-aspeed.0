Return-Path: <linux-aspeed+bounces-4545-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B953C531CA
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 04:14:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Hn55qypz2yVZ;
	Thu, 23 Jul 2026 14:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784780041;
	cv=none; b=MSOV6joaVjAQQ8y3xptwjaWKzYaHpj+8N4VcFXY/OxocWD3T+7bGgM/wYuqEdF1qoeqfnZxIMJrfUN+CwFFXkALzizfZIc2uuX3Eh1BAie+wZuvEUjslNj3D7z+fNGohZblqt47Qsr/4AVK8UEYIj1rgWCiUNxISWRgTv0cO/pIhVjPJQfS56juF7HWMDj5GcBPC2lf+WG2MDMkdAohL8lmNGkpYRcIhgYarludj7HvSo27bSAd1363M080+CFdGAidvpjhy/Kqd2rv20H++hxmOWCtVUagb4zTMsj9GUA3BnwDHl9FgLsT5FaPNtK858Z66pihD2zmFcWJQtTlaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784780041; c=relaxed/relaxed;
	bh=4kyZ+8vlhDWQseod3wYamjQd64WvAC5QZs0pWsqKRcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3Bra5BmT/afrGc91dr8PB0RsjpRzoDnF24xeyI0ERhu68UnGPfKs1adoK/I3ymugZLDbLQb37fOh11Z4Kisp/QQkpaPlnX0gV4Hb7yeeD391dO5qk8mocfs3f8z6o4lYBSjV3pPqMCcqP37QyBwEQqjjA3oDEA7weS1zwj7Wu0aX2SLcpnXCUuYFBieWGCLQXOTJDJov4LiFxSVcho2IIDbjwC8GjmJQJ8I8jxATfqfQUZ4ov3T6JMAfUaDVAmbSPhVo2JFKOhQ/NSReDsSKhkYhJPYjm1W4dFnAW44EsRmI3pXqhcxZWMoh3yZJh6V7HwOC7/o8n5u4lF04ZwTyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Xalw6wZg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Xalw6wZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Hn52wZcz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 14:14:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784780040;
	bh=4kyZ+8vlhDWQseod3wYamjQd64WvAC5QZs0pWsqKRcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xalw6wZgnkGoQBzHgP6CqdIEpb+aiwlBxYf42u9tZI5FG5JAd78Y4AEGIaDNNQf9u
	 bGKHWGrQXyrJXzXedEeKpcXQVGe/cOoHD5ax5tsjgUjQtU8IlIRBxMPwqeFmi7y74g
	 BO7PewybUvcNES/c7ahMAGrF4Fbv7L/GzQNlB57wgHDmCpzUuGeY2mmGCycAlpRVzy
	 D1aZwy62RSdi1YF5jrRGbbRxujpw4+eTmH941bqo3vat2Cl8A/NrWT7dmH6BkgXcxP
	 3qBfvgywzRAuhWp0DI3lXBn1oxw0NFIudB89Q1GWtL36ntf7R6/gECmmZfPhXqru/c
	 To1SuFTJbI47w==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 828F966DF3;
	Thu, 23 Jul 2026 12:14:00 +0800 (AWST)
Message-ID: <4622688c45db99274e6862c15fe665268c9efb10.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] ipmi: kcs_bmc_aspeed: g6: Add KCS Channel 4 over
 PCIe
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>, 
	joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corey@minyard.net, devicetree@vger.kernel.org
Cc: openipmi-developer@lists.sourceforge.net, linux-aspeed@lists.ozlabs.org,
 	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Jul 2026 13:44:00 +0930
In-Reply-To: <a283420c1fb6a99df5331e078c7f15b3c97822c6.1784732161.git.gregoire.layet@9elements.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
	 <a283420c1fb6a99df5331e078c7f15b3c97822c6.1784732161.git.gregoire.layet@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Wed, 2026-07-22 at 15:11 +0000, Gr=C3=A9goire Layet wrote:
> Created a 5th KCS channel to match against the KCS 4 over PCIe addresses.
>=20
> The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
> interface on channel 4. This is a fully KCS-compatible interface
> that is exposed over PCIe.
>=20
> The 5th channel created is only valid on the AST2600.
> This cannot be used for AST2400 and AST2500 chips, as they don't have LPC
> over PCIE.
>=20
> Signed-off-by: Gr=C3=A9goire Layet <gregoire.layet@9elements.com>
>=20

...

> @@ -373,6 +395,9 @@ static void aspeed_kcs_enable_channel(struct kcs_bmc_=
device *kcs_bmc, bool enabl
> =C2=A0	case 4:
> =C2=A0		regmap_update_bits(priv->map, LPC_HICRB, LPC_HICRB_LPC4E, enable =
* LPC_HICRB_LPC4E);
> =C2=A0		return;
> +	case 5:
> +		regmap_update_bits(priv->map, PCIE_LPC_HICRB, LPC_HICRB_LPC4E, enable =
* LPC_HICRB_LPC4E);

This one exceeds 100 chars. checkpatch can help catch these types of
issues.

Otherwise this seems okay.

Andrew

