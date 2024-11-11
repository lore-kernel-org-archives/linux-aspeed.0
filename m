Return-Path: <linux-aspeed+bounces-118-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B974D3ABFA
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 23:53:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnRFg6VtJz2xwD;
	Tue, 12 Nov 2024 10:53:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731369207;
	cv=none; b=Og7FL8hniQ5Vp09mSmjl8Hy/sdd3ptTlWoJyt4kRUT43Ku/O/9UxKPZKB+xNhSkrPCIgXZambI3IO+6LenDs5UNOlmxwJ3c6OpPHWDe+5BQvbzrtM1lsk/7oAeH0e08y7bpx+EPqsi8BRIlQ2aD8MNGNCofKm9N0yNPXs8G1IFxhy5N81UFOY34BYvFsb9EvpbhC1odHcT0wyoTGCjwiii2S+HDMczzrF+q8CW7cIHjulriFJ4xqnzrBvI7Drgx+UIu9nSQt+z2wMq5ndRq5UZKNvcoDTTLxHdvpm6JEToNS32rFnAhUyoqIqq0JR41jx9cFLHa8Is5KdqgoE+qGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731369207; c=relaxed/relaxed;
	bh=/1kbnaXoTlpDzhR7Und7m0yG1HUq2WsmOLWdk0VxH2U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S/+xWRdF7yKANcWBX/dM5H/AjWsXHiQhEp++IIjczjvCK/0+vPuwqMe+QWsrHTlx325Hor4ETPv0+g/1rShQHsXhtsG6MnLmMU6YyJzXG6o9psR7UplekEyfk7ZTlr/oNE37AOmTNDrFBRL1muDKQbnSFsdV94qoRCinnV7jT20fBSAnwlnPVRv3m46stbSrbZQ2pidoUKJkPDUITBhb0l7QEeBU1zBOrfs3KUESNA1l9OQTZEoTt8z1npESMYlDXFoFxp9rLUI0lqhpAeMJXOF8kaOSMOTRSktTKmSfp4+OyZ8dOT5XI5+G/qVguGVWhcr1MwiXOTQ6JVQ/JpEbtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kzYM1tMm; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kzYM1tMm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnRFg1J9qz2xk1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 Nov 2024 10:53:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731369206;
	bh=/1kbnaXoTlpDzhR7Und7m0yG1HUq2WsmOLWdk0VxH2U=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=kzYM1tMmRXj67bu5aN2rYgWXRdBhCtsYVc1CRiDHRq0DMX6IBCZzXs/b3TDGtWyn6
	 8InZgahjgAodowhz+RAX9ztwkB3hwkk66PVyQSN1Ewcbkc048gbBvs5G81SJHk7myO
	 yjh71q0HyINmvgElK7mRITBEanF3XaDA0jD8vAnnpB0uUOW4JfIdHWI26yMQOVMtdP
	 njvoialn2fQdzvn828mP02TFz7IFzkt1aqfG87xSVumEocXTC53xo7XLjozG6vjvGl
	 LdWP+iZXCDay/2Ox1GtDy2SZsyNQ4Y50s3UqlUUhtIwh8lZF+t5GrsGuxC3DekiLC9
	 CEM+G/OcxQ8IA==
Received: from [192.168.68.112] (ppp118-210-164-236.adl-adc-lon-bras34.tpg.internode.on.net [118.210.164.236])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1E96566029;
	Tue, 12 Nov 2024 07:53:25 +0800 (AWST)
Message-ID: <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 10:23:24 +1030
In-Reply-To: <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
	 <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

Hi Peter,

On Mon, 2024-11-11 at 17:43 +0800, Peter Yin wrote:
> =C2=A0 Add:
> =C2=A0=C2=A0=C2=A0 "ac-power-button",
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection0-n"
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection1-n"
> =C2=A0=C2=A0=C2=A0 "asic0-card-type-detection2-n"
>=20
> =C2=A0=C2=A0=C2=A0 "cpu0-prochot-alert",
> =C2=A0=C2=A0=C2=A0 "cpu0-thermtrip-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "irq-uv-detect-alert",
> =C2=A0=C2=A0=C2=A0 "irq-hsc-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "uart-switch-button"
> =C2=A0=C2=A0=C2=A0 "uart-switch-lsb"
> =C2=A0=C2=A0=C2=A0 "uart-switch-msb"
>=20
> =C2=A0=C2=A0=C2=A0 "leakage-detect-alert",
>=20
> =C2=A0=C2=A0=C2=A0 "power-card-enable",
> =C2=A0=C2=A0=C2=A0 "power-fault-n",
> =C2=A0=C2=A0=C2=A0 "power-hsc-good",
> =C2=A0=C2=A0=C2=A0 "power-chassis-good"
> =C2=A0=C2=A0=C2=A0 "presence-post-card",
> =C2=A0=C2=A0=C2=A0 "presence-cmm"
> =C2=A0=C2=A0=C2=A0 "pvdd11-ocp-alert"
>=20
> =C2=A0=C2=A0=C2=A0 "reset-control-cmos-clear"
> =C2=A0=C2=A0=C2=A0 "reset-cause-pcie",
> =C2=A0=C2=A0=C2=A0 "reset-cause-platrst",
>=20
> =C2=A0=C2=A0=C2=A0 "P0_I3C_APML_ALERT_L",

Rather than list the identifiers that are already contained in the
patch, can you please discuss what functionality these identifiers
enable, how different functions are related, and why this must all be
done in one patch?

>=20
> =C2=A0 Rename:
> =C2=A0=C2=A0=C2=A0 "power-cpu-good" to "host0-ready",
> =C2=A0=C2=A0=C2=A0 "host-ready-n" to "post-end-n

On the other-hand, explicitly calling out these changes is helpful, but
please also discuss the motivation and impact.

Andrew

