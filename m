Return-Path: <linux-aspeed+bounces-1027-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEB8C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:01:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGtp33zJBz2yVb;
	Tue, 18 Mar 2025 12:01:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742259691;
	cv=none; b=dFX76zlpiEuTCaz5d/lDU95gf+NIsN+sl0+fE2gAmz3xTywx8gF86NufvQv7I6lL7yLl91VgLliDjrr5dPglw2r3++QcVUOCTg5KYonaIF6s1ivatu5GOc3DbNnkmtVvSmDhHUHqej7Jmt9jMNREkVaAxjp3l0cf5GcQ+oahVWI6P8jgoWRSgvUxeFM8p+vzWGE6XdK0DsDfwA8zMYMo9abDeZWlIg29pHXxmOPh8XNa3rpmwZH6WIU3MGWZ8KEIoD5gHVEeNr3URi99+hCy/YD4RSWVWu+bM5VIAVXRxH1Mtoe9ntDChK9iwVxlnHt7o8mz3K2i718sP2tepZj1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742259691; c=relaxed/relaxed;
	bh=1hZje+jxZfrx+KaPWN6vekAQrfxr7l4TiRtGTI/exVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYQQgU/OH6uKQrbVIthrSNIUG2iB+iIkUTGLRh5kISLQxZfjFihXaxczNrP+HUKrnHmWXKJthMJ7qmJAmSjJVkh4dJlwBnmWOxXupQBuH4+aptqqVnrizO3CJubuu9tEAuRivRvdCYw+2GjEox9B59t35bzB0XlZ39igAueyqf29Q1TO3LIIIse2OJciZOixfAD7dpyRNwMW7HBJNtv50JZxL4ESIJjm1IDNRuvyQ/+Qc5nFvhsTQvIqmWQG/jGKRd0xOxGRa8tC7JoQpnuP0hI/HaF7gYtvgy35A2r1TkV0laIrYh8Wgmj9Vqs2WC8gGSUCvpiui4flryykmmKsaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BobPYzLS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BobPYzLS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGtp3089sz2ySX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:01:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742259690;
	bh=1hZje+jxZfrx+KaPWN6vekAQrfxr7l4TiRtGTI/exVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BobPYzLST/TRw9QRnyQAHrTxdAt47Ng486vGBIZtSI37jjtt+zjXQLIiiR9+qDbT3
	 yb7LyYLZleDJjQDM3AFHWiB8rfTLb7d2B+z+nLVm/VR133Y3f91V94PaT96ZAkMKLU
	 XOqsr+tdthkUxE7/VSHBnny0YvtgOxLc9Dh4XUMpJsJGFEsrnNwLN/6w0xnCx6XvOh
	 4WSEK1FolypjvygHRVX4z4dZQSxMxFu8mQRpXDIR8DighdyqwGjCZQyKos51Mijg7X
	 9/oE1ZfNwyK59MpEydPQJGfcT98SIaE2AH+A2JYp09Cf4qCsZt9DuFh4VhfMKCX3t9
	 LhwzvEwZl9exA==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1ABF177BB4;
	Tue, 18 Mar 2025 09:01:30 +0800 (AWST)
Message-ID: <5fd732f2cffefd65bfcba983ecf5e11fedb5bc2d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: Add Balcones system
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Eddie James <eajames@linux.ibm.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org
Date: Tue, 18 Mar 2025 11:31:29 +1030
In-Reply-To: <CAL_Jsq+QF6m1YD_MKi0mxJWtn0n+f+iL2x-jYv3NWytv0X4Jjg@mail.gmail.com>
References: <20250220205948.1777200-1-eajames@linux.ibm.com>
	 <174015998324.3469672.1009055817022487781.robh@kernel.org>
	 <52f6f6fc93144b6bd93870e9ef054da19d809b05.camel@codeconstruct.com.au>
	 <0801c8fc-97c8-4331-b31a-b60a90d683e5@linux.ibm.com>
	 <CAL_Jsq+QF6m1YD_MKi0mxJWtn0n+f+iL2x-jYv3NWytv0X4Jjg@mail.gmail.com>
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

On Fri, 2025-02-28 at 11:23 -0600, Rob Herring wrote:
> On Fri, Feb 28, 2025 at 10:46=E2=80=AFAM Eddie James <eajames@linux.ibm.c=
om>
> wrote:
> >=20
> >=20
> > On 2/24/25 22:34, Andrew Jeffery wrote:
> > > On Fri, 2025-02-21 at 12:11 -0600, Rob Herring (Arm) wrote:
> > > > On Thu, 20 Feb 2025 14:59:45 -0600, Eddie James wrote:
> > > > > The Balcones system is similar to Bonnell but with a POWER11
> > > > > processor.
> > > > >=20
> > > > > Changes since v1:
> > > > > =C2=A0 - Add all the ucd9000 driver supported compatible strings
> > > > > =C2=A0 - Fix node ordering in Balcones device tree
> > > > > =C2=A0 - Improve commit message to explain addition of ibm-
> > > > > power11-dual.dtsi
> > > > >=20
> > > > > Eddie James (3):
> > > > > =C2=A0=C2=A0 dt-bindings: arm: aspeed: add IBM Balcones board
> > > > > =C2=A0=C2=A0 dt-bindings: hwmon: ucd90320: Add additional compati=
ble
> > > > > strings
> > > > > =C2=A0=C2=A0 ARM: dts: aspeed: Add Balcones system
> > > > >=20
> > > > > =C2=A0 .../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > =C2=A0 .../bindings/hwmon/pmbus/ti,ucd90320.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 +
> > > > > =C2=A0 arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > > =C2=A0 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts=C2=A0=C2=A0=C2=
=A0 | 594
> > > > > +++++++++++++
> > > > > =C2=A0 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779
> > > > > ++++++++++++++++++
> > > > > =C2=A0 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +-----=
-
> > > > > ----------
> > > > > =C2=A0 6 files changed, 1383 insertions(+), 767 deletions(-)
> > > > > =C2=A0 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm=
-
> > > > > balcones.dts
> > > > > =C2=A0 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-
> > > > > dual.dtsi
> > > > >=20
> > > > > --
> > > > > 2.43.5
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > > My bot found new DTB warnings on the .dts files added or
> > > > changed in this
> > > > series.
> > > >=20
> > > ...
> > >=20
> > > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb:
> > > > gpio@1e780000: 'usb-power-hog' does not match any of the
> > > > regexes: 'pinctrl-[0-9]+'
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from schema $id:
> > > > http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> > > Ah, can you address this one?
> > >=20
> > > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb:
> > > > /ahb/apb/bus@1e78a000/i2c@400/pwm@53: failed to match any
> > > > schema with compatible: ['maxim,max31785a']
> > > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb:
> > > > pressure-sensor@76: '#io-channel-cells' does not match any of
> > > > the regexes: 'pinctrl-[0-9]+'
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from schema $id:
> > > > http://devicetree.org/schemas/trivial-devices.yaml#
> > > And these also?
> > >=20
> > > The rest looked like the usual noise.
> >=20
> >=20
> > Well, all of these errors are also present in Blueridge. I would
> > need to
> > write a new binding for dps310, move max31785 to yaml format, and
> > I'm
> > not sure how to fix the gpio hog one. I don't see that error when I
> > run
> > CHECK_DTBS myself... any suggestions?
>=20
> I think the hog one got fixed recently. The tests run on top of
> whatever b4 picks for the base or linux-next if it can't figure out
> the base. So that might be the difference.

Eddie: Yeah, disregard the hog one. An alternative to
writing/converting the bindings is dropping the relevant nodes for now,
and adding them back once the bindings have been dealt with. Up to you.

Andrew

