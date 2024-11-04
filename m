Return-Path: <linux-aspeed+bounces-70-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6F6D11186
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Nov 2024 00:02:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XhWqN2xXJz2yHT;
	Mon,  4 Nov 2024 11:02:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730678528;
	cv=none; b=IM1qoxFGVBibXdfwEmI2gf06SlnDlqq1zvijBswF0XfYDjfr5S+o/Fr9AjWQOjbWxWZ6GGrQF1zE3MHlAuI7G8dvjLD6XH2NdBwN3PuSnPDCk5eTjvN7o8S+HfMSs/8UJ9OHXC/I4y4NlxxsB18TVyGThNGiF842DVM+mvzV9hPrhF7vUcnTB7hjlCGoigWBiK3kyRSatlNNNtHJm3JMTZg9y0Jf+GXZ0F0LDggRWVBX1Uge4iUsS78o6+lLR4Gspk9Z1mp/J2wjsrwMjvtCfJ9P3F5ScT/zwMm8Tl8mhzDA2Ma07jgKHUHOzGgcD8GSuPfpkH4WZ0sAyHjxRjlJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730678528; c=relaxed/relaxed;
	bh=cm86/adYBO0QLMJTj80moqy+OSpgRV+dDfE8QASkuLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SyJ8nnZrCDdek3Nl2/KgqCeFb75DOUOKomJE22+5At3Mcn7k9YGPEq8oVcWqPnot1OERQ749YYO1tWVAOUAkQuQ5NGcUgdyMeTxfoN9YCRyseKWr2tkwtvZW5WXMKwulNuDMfX3ItQtUBu4MB/ZVwgEu1EnYp3HpDcS7YSN6Ly+amfRuiobVRqxFUpWTy239LE6nqtnbYEh3bLFZax8TVb+KY3Vggqrcw36WFaMGsxPP3eHu2fjfMHltMP1NFYw3HgiJ2rknAa6BKALO07BFEt3ZtyeWhHV92qEaJxcA2XEMM9voxKnhMZteF/Nsly2tWqZ+Kwj5/LJvbL3uy9oyOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QqHI7rhE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QqHI7rhE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XhWqL3CZfz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Nov 2024 11:02:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730678522;
	bh=cm86/adYBO0QLMJTj80moqy+OSpgRV+dDfE8QASkuLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QqHI7rhE5NLaRyprE6WKCAik4rWO9TXIZB8hGClSE0eoL/ZotGcXIg8mRB7oU/7xj
	 kKBFAqApO2jqrhOsUaShqbFNdA3JYCPpxtIMhAils8Zcc7L9C4C96eRKrPy1SbdkJX
	 W1euBcmLyVCXNvtuPlToaN7Oi6PgBIa1C8LloZyod9/W8EnmkJkuxNpptAXzgDWqhF
	 DMjeArBbGADfnVWfgqY1Qzf2FofpzPF1RyI1vnwpXbNYdtTRvjjiCqybuSd4Gqt9eG
	 AFwFi9LJRTSw7t/p3RcI3pZEfUUXKRiH3c25Q1/02Gy+kOAxnCREW3CKLmNoHikiHO
	 vVW9CrOl1jbxw==
Received: from [192.168.68.112] (ppp118-210-95-135.adl-adc-lon-bras32.tpg.internode.on.net [118.210.95.135])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2EBC66A03A;
	Mon,  4 Nov 2024 08:01:56 +0800 (AWST)
Message-ID: <a0faca9a6ec7f4acdfa2f29b4ffb94b5392aea6b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus handling
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Chin-Ting Kuo
	 <chin-ting_kuo@aspeedtech.com>
Cc: joel@jms.id.au, wim@linux-watchdog.org, linux@roeck-us.net, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com, Bonnie_Lo@wiwynn.com, 
 DELPHINE_CHIU@wiwynn.com, bmc-sw@aspeedtech.com,
 chnguyen@amperecomputing.com
Date: Mon, 04 Nov 2024 10:31:55 +1030
In-Reply-To: <ZyUcIIb1dtoNhX00@heinlein.vulture-banana.ts.net>
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
	 <20241101121201.2464091-2-chin-ting_kuo@aspeedtech.com>
	 <ZyUcIIb1dtoNhX00@heinlein.vulture-banana.ts.net>
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

On Fri, 2024-11-01 at 14:21 -0400, Patrick Williams wrote:
> On Fri, Nov 01, 2024 at 08:11:59PM +0800, Chin-Ting Kuo wrote:
> > The boot status mapping rule follows the latest design guide from
> > the OpenBMC shown as below.
> > https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-up=
date.md#proposed-design
> > - WDIOF_EXTERN1=C2=A0=C2=A0 =3D> system is reset by Software
> > - WDIOF_CARDRESET =3D> system is reset by WDT SoC reset
> > - Others=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> oth=
er reset events, e.g., power on reset.
>=20
> I'm quite surprised that the above is relevant for a kernel driver at
> all.=C2=A0 Isn't "EXTERN1" a name of a real watchdog signal from your
> hardware (my recollection is that there are 2 external watchdogs).

I think you may be referring to WDTRST1 (and WDTRST2) here.

WDIOF_EXTERN1 and WDIOF_EXTERN2 have an unrelated history:

https://github.com/torvalds/linux/blame/master/include/uapi/linux/watchdog.=
h

> =C2=A0 I
> think the point of this referenced design document was that most
> users
> of BMCs have "EXTERN1" used a for software reset conditions.
> `CARDRESET` should be representing resets by the watchdog itself.

I think this is what Chin-Ting is proposing for the Aspeed driver?

>=20
> The purpose of this design proposal was not to require very specific
> changes to individual watchdog drivers, but to align the userspace
> use
> with the best practices already from other watchdog drivers.=C2=A0 I don'=
t
> think the kernel driver should be bending to match a particular
> userspace implementation; you should be exposing the information
> available to your hardware.

I agree with this in principle, but I'm not sure what else is meant to
be done here.

>=20
> Having said that, it was known that there would need to be changes to
> the driver because some of these conditions were not adequately
> exposed
> at all.=C2=A0 I'm just still surprised that we're needing to reference
> that
> document as part of these changes.

I think the main question is whether an internal, graceful (userspace-
requested) reset is a reasonable use of WDIOF_EXTERN[12]. My feeling
no. I wonder whether defining a new flag (WDIOF_REBOOT?
WDIOF_GRACEFUL?) in the UAPI would be acceptable?

Andrew

