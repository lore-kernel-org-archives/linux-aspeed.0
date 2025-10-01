Return-Path: <linux-aspeed+bounces-2357-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E69CCAC5B8
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 02:29:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbzQl55pvz306S;
	Wed,  1 Oct 2025 12:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759285775;
	cv=none; b=C8OMSLCRBN++tFOIo3SKTi3cdCFdrpgsSXlLRtR0b9/y2j/WrjW0Z42bJkWEtlOckL1XZdNJ5bmEiMMOZzqxNebtfsze39DjWC02SqCZW60sdyj+lPSDCIfxd0y+8IkntoAZbwhhGc+Vf+wvP4kOjBAlhqTDu7M9NtbrBIsU/TcmrbLfXvNTTMmEEy78fRuvbK70V2YLEZAeg3uwukTkEFqiVwR1Cjx2FPi2Yp2RkitIwxy16qj+qwiIqBOHWMuWdo+jSX8R+pe6meX0Oh5MDPndPID21vLjdLCIq46KcxutnmiH6GO1oNwjm5Sp2/iwc9sjoupdpLGffjbw5UbSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759285775; c=relaxed/relaxed;
	bh=93pG2cTrl3v8hG0ltG0HHnvRP5q7qH37lHtkS5rvRE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RDYore/jnhgYakoItaWgyjTs7nI5Xj0/X0f9TRBtb2NaNvIxrJ1eJLmSFaYxAKVlhN6WGKsKh3MAtio+cg/8PtM6a6Mzy+4m42eki7mZ8kBtfSviUPWP0NFwLeF9va5nP/7yyH8Tk+ROH9PKt0kUrJu8KpVDs8ohBun9yKZaHmtphMhhYOE9axLfxYvSM+0RZb4U3U4L9SeXOvl7L5qqOpKCNMkwJ1A/13CCizezeq0kSjBNtPNKvOBpfQb/kslrH7v8ARqckifGC5hdNzt7HdRrT5TmoX3GLI55oqC6Kn50u9RtqAHDLJj+IrUUSjXmaSYV87pciD8Y1eKbhrk8PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nLxkowWd; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nLxkowWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbzQk3kH8z2yN1
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 12:29:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759285772;
	bh=93pG2cTrl3v8hG0ltG0HHnvRP5q7qH37lHtkS5rvRE8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nLxkowWdJ3hPG4s8670dXGq74doY3FrG6nywm9zsB5SL537KV4oTjgx7Il+mneowR
	 84HaBVdwy2RKUH5sa2xwgJL3/hU0dPyx5kniGv2QuYoieGBta23lwcURShSC3m02ab
	 PGIWccSBpT90REbcmY0BhxLKEz1eE+Mhj0kkvkbDCNsAE5TKCSvVctHL8OUKHH7LF+
	 JFxR6ynULedTnxWfIjdJCkV9fSAjqqdKG2y7yv7tRBkv0NvN2qxfH3KvcAeR3TBHit
	 E1DiQeYTd35M2AybyodQ8mNk3CMzlUUi9xjptL32HsqL26Ilt7Njz6ePKNsdaFtFqg
	 3JYpGDZahDWfg==
Received: from [IPv6:2405:6e00:243e:cd99:1d87:95e3:706d:5dc7] (unknown [120.20.48.42])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8458464785;
	Wed,  1 Oct 2025 10:29:30 +0800 (AWST)
Message-ID: <7751dff931924c151f976feeafe4a888dc2095ad.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 6/7] ARM: dts: aspeed: Add Balcones system
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org
Date: Wed, 01 Oct 2025 11:59:30 +0930
In-Reply-To: <4632dab2-d6c7-4abf-8449-bd61d5ad94ad@linux.ibm.com>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
	 <20250922175804.31679-7-eajames@linux.ibm.com>
	 <6d117ac3297628ee6e315894460d348647b68c7f.camel@codeconstruct.com.au>
	 <4632dab2-d6c7-4abf-8449-bd61d5ad94ad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Mon, 2025-09-29 at 09:52 -0500, Eddie James wrote:
>=20
> On 9/25/25 7:03 PM, Andrew Jeffery wrote:
> > On Mon, 2025-09-22 at 12:58 -0500, Eddie James wrote:
> > > The Balcones system is similar to Bonnell but with a POWER11 processo=
r.
> > > Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
> > > tree is needed. Therefore, split up the quad chip FSI tree.
> > >=20
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > ---
> > > =C2=A0=C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0=C2=A0.../dts/aspeed/aspeed-bmc-ibm-balcones.dts=C2=A0=C2=A0=C2=
=A0 | 609 ++++++++++++++
> > Looking at Balcones specifically, there's still an immediate concern:
> >=20
> > =C2=A0=C2=A0=C2=A0 /home/andrew/src/kernel.org/linux/origin/build.arm.a=
speed_g5/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: pressure-sen=
sor@76 (infineon,dps310): '#io-channel-cells' does not match any of the reg=
exes: '^pinctrl-[0-9]+$'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from=
 schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>=20
>=20
> Hmm, patch 3 in the series fixes this.
>=20

Indeed.

>  Did you apply that one?=C2=A0
>=20

I hadn't, as I can only take patches 1-2 and 6-7 through the bmc tree.
3 and 4-5 should go through the iio and hwmon trees respectively.

Having tested after integrating the whole series I've applied 1-2 and
6-7 to aspeed/arm/dt.

Thanks,

Andrew

