Return-Path: <linux-aspeed+bounces-869-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C197C282C6
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Feb 2025 17:23:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4FRs5DKsz3bsm;
	Sat,  1 Mar 2025 04:23:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04::f03c:95ff:fe5e:7468"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740763433;
	cv=none; b=WE2vpTliDqG1ww9WgY80XXEEaM+CviYosIBhFcHeGvnNkF+PHXHJAtP/5AtENLr/URV8665L1jt6La4ogFtEGrrxHo+8zN+3AklbgDN2Hn/94rGzeFT04XkwF8My3c0OPZ+87ocKA61sE6L7jh5F1Y+dtNEDK2lCJySwaXfFow25Ay3DsnnZ6hTRyYyMVG5ilaaDMxd8+03XmkDqy+67Out5JNsxlpxs7UCubsdNvqDDJ8yxU0x9vGRk0HpwdMicDemFK2Qbw12Yaw3O9IBEVqZyZ2RNxu3ihseDTGKjaTTqfGVQqkqo4Vdn8QA+Ts0LFaVO3gluP+sSYMndz6Pvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740763433; c=relaxed/relaxed;
	bh=6hyDDTNNJxYiC0JGOsC1ghPe4P6g7XvyW+f2+ZIlOgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nunuSBYwRD0/oJ5YRMycZiWbfihUj4Foyu9wJidUY+hvxU6gXEGoFIdp4b1sjhQh2SkL7vvmZdK3ghjX8PJws3lnWyBLAWYQAhJSyYiTcXEXIAKSAn/Z6gYdzQi/J4dncXHjotIFLhfa+JZ9VmB1BRqnNmSJwx7SNe0CXJiAflKnIp8nOcfFTPIfDMhueH+djs+y8/iHtlo7hu5D6v5a+nN2iMRZF+oLShpY8arkGgxzo+xmi03q6OxIAkANQi0skizCIPBbkkVcgc8fpFJCP/+TZnIqahYSZkJMtFuH4HzRCq3ZqeTBy5bFdhayozE6HmAUO4Jff5X65jiUuxiw0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rBnydU+K; dkim-atps=neutral; spf=pass (client-ip=2600:3c04::f03c:95ff:fe5e:7468; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rBnydU+K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04::f03c:95ff:fe5e:7468; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04::f03c:95ff:fe5e:7468])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4FRr5WzNz3bm3
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 04:23:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B7E161FB0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 17:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B196C4CEE8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763430;
	bh=BPMdmayMKnKCf+wmiSD4Nr+WPj6p2B16Q/gtVT6ljF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rBnydU+K9B/Rzf0zhOx/76XqY/YLdjCMz3Vpeih2WcmKMONUqQzOP7A0vmzuEWZ18
	 Pqid1Ax2pX/+qPe+VWeRu519Kk3JVjCH/YUB4r3tJOwtY1/Qz3ywPXp5qTPh9gsQwB
	 zt6q0VyFqAN+PKzl3pnmBDQDvr6Lz1V0PnCGg8hSB4wm54jx46k+QVTbG9zAvvSVQJ
	 Vom4IwpBoIHVnVmAWl9ErP1BIrFDSgVtDAmzraYi3J2gNHptat1/r35K57uYD00HTZ
	 jCGutkXUKu8YJdUgLZ1xUhui9Dye4j6e3LoF32XH378Hk3JJhnaW6FkjX0xtrbTDar
	 0uXbMVA5SmRpQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so4488918a12.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 09:23:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYoMNPw5T5UVT1cTnylMcQSZ12KqF77MsfOVjQZaZK6t2TO9cSPfRAQzef+kklVRrE/Ykim0ioMEwD5dI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxsPYz4hqPJ0M1p8IBA5+3RlAAGw+eFu12aIThINmuuyszcwj0u
	Zpk19ARTM37MWTYGlcVsrZNfs+v/Vv3gczvnJFguAXYTGvKDULUDlM3LLFZ4Ilzr5+1wfnfxxHn
	hf+aaQGWHTWNqDaKabOSrsn+fAw==
X-Google-Smtp-Source: AGHT+IEF4YJkKFTBhE9KWRl7WTdYoSsW8Pb5XbVNma0j2MhrQqNt9B/x5iHLLs444cMWjSTUJJ5Y1WrUIPN1MSKevKY=
X-Received: by 2002:a05:6402:26c9:b0:5de:572c:72cf with SMTP id
 4fb4d7f45d1cf-5e4bfb8067bmr10617010a12.10.1740763428947; Fri, 28 Feb 2025
 09:23:48 -0800 (PST)
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
References: <20250220205948.1777200-1-eajames@linux.ibm.com>
 <174015998324.3469672.1009055817022487781.robh@kernel.org>
 <52f6f6fc93144b6bd93870e9ef054da19d809b05.camel@codeconstruct.com.au> <0801c8fc-97c8-4331-b31a-b60a90d683e5@linux.ibm.com>
In-Reply-To: <0801c8fc-97c8-4331-b31a-b60a90d683e5@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Feb 2025 11:23:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QF6m1YD_MKi0mxJWtn0n+f+iL2x-jYv3NWytv0X4Jjg@mail.gmail.com>
X-Gm-Features: AQ5f1JqBLw6WhoVAtURMFtGm6_JqPAKGxjGEqN_WcyPWC4VS-6OdV3fJ7PJIe-Q
Message-ID: <CAL_Jsq+QF6m1YD_MKi0mxJWtn0n+f+iL2x-jYv3NWytv0X4Jjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: Add Balcones system
To: Eddie James <eajames@linux.ibm.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, krzk+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:46=E2=80=AFAM Eddie James <eajames@linux.ibm.com=
> wrote:
>
>
> On 2/24/25 22:34, Andrew Jeffery wrote:
> > On Fri, 2025-02-21 at 12:11 -0600, Rob Herring (Arm) wrote:
> >> On Thu, 20 Feb 2025 14:59:45 -0600, Eddie James wrote:
> >>> The Balcones system is similar to Bonnell but with a POWER11 processo=
r.
> >>>
> >>> Changes since v1:
> >>>   - Add all the ucd9000 driver supported compatible strings
> >>>   - Fix node ordering in Balcones device tree
> >>>   - Improve commit message to explain addition of ibm-power11-dual.dt=
si
> >>>
> >>> Eddie James (3):
> >>>    dt-bindings: arm: aspeed: add IBM Balcones board
> >>>    dt-bindings: hwmon: ucd90320: Add additional compatible strings
> >>>    ARM: dts: aspeed: Add Balcones system
> >>>
> >>>   .../bindings/arm/aspeed/aspeed.yaml           |   1 +
> >>>   .../bindings/hwmon/pmbus/ti,ucd90320.yaml     |   6 +
> >>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >>>   .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 594 +++++++++++++
> >>>   .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 +++++++++++++++=
+++
> >>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +--------------=
--
> >>>   6 files changed, 1383 insertions(+), 767 deletions(-)
> >>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones=
.dts
> >>>   create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
> >>>
> >>> --
> >>> 2.43.5
> >>>
> >>>
> >>>
> >>
> >> My bot found new DTB warnings on the .dts files added or changed in th=
is
> >> series.
> >>
> > ...
> >
> >> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: gpio@1e780000: '=
usb-power-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>          from schema $id: http://devicetree.org/schemas/gpio/aspeed,as=
t2400-gpio.yaml#
> > Ah, can you address this one?
> >
> >> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/bus@1e7=
8a000/i2c@400/pwm@53: failed to match any schema with compatible: ['maxim,m=
ax31785a']
> >> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: pressure-sensor@=
76: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>          from schema $id: http://devicetree.org/schemas/trivial-device=
s.yaml#
> > And these also?
> >
> > The rest looked like the usual noise.
>
>
> Well, all of these errors are also present in Blueridge. I would need to
> write a new binding for dps310, move max31785 to yaml format, and I'm
> not sure how to fix the gpio hog one. I don't see that error when I run
> CHECK_DTBS myself... any suggestions?

I think the hog one got fixed recently. The tests run on top of
whatever b4 picks for the base or linux-next if it can't figure out
the base. So that might be the difference.

Rob

