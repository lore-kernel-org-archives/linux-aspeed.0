Return-Path: <linux-aspeed+bounces-103-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8162DD5D699
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 23:49:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkzM66q4xz3bp1;
	Fri,  8 Nov 2024 10:49:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731023378;
	cv=none; b=SuqGwhfu1lTetljT5XlnFq0NXnJfxbz9tKAPTFzWHuPbq0/znRSjisgLDBasD1+AnBXXqAm9y+Q7ijnjYEf9oAjiZ7iqFZVVDMqrHPS3+rq41R/XJWLA8fFruUM77p/TrFsNd6NBhCRibMKoQnSIHs4+2vj2hfcA0zDJ89qsuWOi5iE8pVv3zzY7Agd8QHz+2K7JeBVLg67SYQMkNMdvNOLxWtXoy0+3ouW9zF+yG/XlBFDe4Ix3VUfWi2jrJqkMQ7/G0G0iEIxxLHZjywxldSOOKUS4sGr9f5GISELF0OT+jO7inCOHvwCFOy1jR6k5RgsGPYVCouMCbH2h09+uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731023378; c=relaxed/relaxed;
	bh=p2kk6Hi41/Ro/71xlCn7nSIBe3j3Ua27rEHjt50nD+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkVy3BrciCY7ifw+6AwAhH8w0t3VvuzS+Jkq8oXZHMTRZwPuXBFzEZJLpsJpkOjrm46OGc9TvU6+vVyHpV1fV+zGHGiTXzNUnYRAyWT1x3KqkDmaZSZVYtRdrlv9b2wLf2vNP47No9Q1V5U2iJjgTaxjq74FGoOFXJWiEQvsODBip+oIjXcda2zTNaFEi1yBRV6RKyvVGQ5YCIOAhO3cTjni0C1EtSTxDfQ+QX7Nep0Qx9byr0mjKnU48uTUU+a7y+vD3BJj3C8hXFmyv33Jls2ujYqmYlmajix7vkeVzLOnVlfX1adnhwtPEAWjJgFxNjlonaAWRWZKRn54w4UynQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EBtdjaAH; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EBtdjaAH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkzM572HLz3bn9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Nov 2024 10:49:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731023377;
	bh=p2kk6Hi41/Ro/71xlCn7nSIBe3j3Ua27rEHjt50nD+I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EBtdjaAHWRxXhfz8E3EXbIwgrYhv9xSEM8jRmHASRjDiZmfjWDvgig5I9KA9TGwAn
	 bwdtQtrW1Bi0FszAYf2ySq2ONGvFI2J3CVBilPvpDpXMKBc6lrJtCgKXbMRKyW3jco
	 VF4nI772R2yLDrWDipnNyKv8g13a51byGXbFfS9JWNsdyXOcQboImaKqivg1Cev/sp
	 M+CND0O1jc0barD0lqTXMXWYagjLffmHPhNpocbUjPlJaHU9vzCFkaKqO9Rn+006o+
	 V2pQvSP8NUUXX96YEnIE3K++DWYjy0bIJJSPOT4Rooygp1UWLep5HZmlQJdxUKxBLt
	 jj8Zwer5xhkdw==
Received: from [192.168.68.112] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EB6136B922;
	Fri,  8 Nov 2024 07:49:33 +0800 (AWST)
Message-ID: <ed77d57facaaef0be796b4c6a742dc7bf3bff479.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus handling
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, Patrick Williams
	 <patrick@stwcx.xyz>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, 
	"linux@roeck-us.net"
	 <linux@roeck-us.net>
Cc: "joel@jms.id.au" <joel@jms.id.au>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>, "Peter.Yin@quantatw.com"
 <Peter.Yin@quantatw.com>, "Patrick_NC_Lin@wiwynn.com"
 <Patrick_NC_Lin@wiwynn.com>, "Bonnie_Lo@wiwynn.com" <Bonnie_Lo@wiwynn.com>,
  "DELPHINE_CHIU@wiwynn.com" <DELPHINE_CHIU@wiwynn.com>, BMC-SW
 <BMC-SW@aspeedtech.com>,  "chnguyen@amperecomputing.com"
 <chnguyen@amperecomputing.com>
Date: Fri, 08 Nov 2024 10:19:32 +1030
In-Reply-To: <TYZPR06MB5203053A004676F51322DECFB25C2@TYZPR06MB5203.apcprd06.prod.outlook.com>
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
	 <20241101121201.2464091-2-chin-ting_kuo@aspeedtech.com>
	 <ZyUcIIb1dtoNhX00@heinlein.vulture-banana.ts.net>
	 <a0faca9a6ec7f4acdfa2f29b4ffb94b5392aea6b.camel@codeconstruct.com.au>
	 <TYZPR06MB5203053A004676F51322DECFB25C2@TYZPR06MB5203.apcprd06.prod.outlook.com>
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

Hi Chin-Ting,

On Thu, 2024-11-07 at 05:35 +0000, Chin-Ting Kuo wrote:
> Hi Andrew,
>=20
> Thanks for the check.
>=20
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Monday, November 4, 2024 8:02 AM
> > Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus
> > handling
> >=20
> > On Fri, 2024-11-01 at 14:21 -0400, Patrick Williams wrote:
> > > On Fri, Nov 01, 2024 at 08:11:59PM +0800, Chin-Ting Kuo wrote:
> > > > The boot status mapping rule follows the latest design guide
> > > > from
> > > > the OpenBMC shown as below.
> > > > https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-caus=
e
> > > > -update.md#proposed-design
> > > > - WDIOF_EXTERN1=C2=A0=C2=A0 =3D> system is reset by Software
> > > > - WDIOF_CARDRESET =3D> system is reset by WDT SoC reset
> > > > - Others=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>=
 other reset events, e.g., power on reset.
> > >=20
> > > I'm quite surprised that the above is relevant for a kernel
> > > driver at
> > > all.=C2=A0 Isn't "EXTERN1" a name of a real watchdog signal from your
> > > hardware (my recollection is that there are 2 external
> > > watchdogs).
> >=20
> > I think you may be referring to WDTRST1 (and WDTRST2) here.
> >=20
>=20
> WDTRST1, wdt_ext, is a pulse signal generated when WDT timeout
> occurs. However, depending on the HW board design, wdt_ext doesn=E2=80=99=
t
> always affect the system reset. Thus, EXTERN1 boot status can be
> ignored in ASPEED WDT driver and just implement "CARDRESET" and
> "others" types since EXTERN1 is not always affected/controlled by WDT
> controller directly. Or, an additional property in dts can be added
> to
> distinguish whether the current EXTRST# reset event is triggered by
> wdt_ext signal.

Yep, I understand how it works. I was responding to Patrick's query to
clear up some confusion around the watchdog signal names.

> >=20
> > >=20
> > > Having said that, it was known that there would need to be
> > > changes to
> > > the driver because some of these conditions were not adequately
> > > exposed at all.=C2=A0 I'm just still surprised that we're needing to
> > > reference that document as part of these changes.
> >=20
> > I think the main question is whether an internal, graceful
> > (userspace-
> > requested) reset is a reasonable use of WDIOF_EXTERN[12]. My
> > feeling no. I
> > wonder whether defining a new flag (WDIOF_REBOOT?
> > WDIOF_GRACEFUL?) in the UAPI would be acceptable?
> >=20
>=20
> Agree, but this is out of the scope of this patch series and can be
> discussed and
> implemented in the other future patches.

I disagree, because then you're changing the userspace-visible
behaviour of the driver yet again. I don't prefer the proposed patch as
the way forward because I think it is abusing the meaning of
WDIOF_EXTERN1. I think the concept needs input from the watchdog
maintainers.

Andrew

