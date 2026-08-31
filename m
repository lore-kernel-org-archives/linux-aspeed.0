Return-Path: <linux-aspeed+bounces-4887-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD7CC61DFD
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 23:59:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmDm2lKdz2y2h;
	Tue, 01 Sep 2026 09:59:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1129" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788144214;
	cv=pass; b=Q5LWR+SfGgtsQzJRK4oRL1o2YwICpg5qkHW4axjpZrHE5MBl54NUTa+bnvSXX+h5d7QrtLV2w3x6hFTNmlXWyhUTlXMSruohGE//e64pnrI6RlIUwIC/H9FlgnTktXPOXdCSSXc8J6Ivo18usJwegyxbU8W4n0eKr3Wop2BDkDp9JkD1SBji79DSNyq2KjfjfG3y5qfwr9WQzAO9j0AhU7wQlstr7tCitxuroNzCsgMZwUbIYzry1YvshmtchfJL0LFCnxHbwjJdN2/A3fF57cKQ40ba2zqEmQ3nLYBT1DVsdhBzLOkS6AmQ++wRW4Bg+u6QZ2ptjoXmsXIrZ47A3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788144214; c=relaxed/relaxed;
	bh=NbE6ygLElQTTYS/K7ZqBXF2buqZVjb40e1vBsSRV3Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4XVgOrDJDfQELnfMPTGy4LOkMZX+5xizc+5yS0cJy9coshUc6oGDOLv9hvWaN+5TuJqPbYjqvtMREpMFUw5QewMroVyrv+pYaZwmlehO/V/o2v/bnfhhgmWvjxIbcZ7Y4dNJIeZmlkklq07h/pn8RX1vLhlmGujmeOh0uLIUX807j/h9Kf7KB9oxg9Hisl0IpJlYyxQbWTsGPUrTuhlLSd1V+YRJBjH5MHWIXop8EmWaCldb711WU25/VSm1EQOE6fMYQodGSjOZ9W1iXMgnjDWp2GLUdh6HaHtces8cLFoj+a2ETa+Zd6Kj5NAp8zuEi7xFk8zoI1TpZhl0adEgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KXF/Dpji; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KXF/Dpji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYCwh5sTXz2xlv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 12:43:32 +1000 (AEST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-836c8bdac50so31481697b3.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 19:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788144210; cv=none;
        d=google.com; s=arc-20260327;
        b=WFqjvo9rLNfcOZCOS3e8P7bpZcNaoAizgHlZcUG0RCnYq+BFPzcggV5Zn/f6Dz/QdR
         7ugAov/Di8aVsITIXM2kCVnpPEOSzjc68JP22VZk3Qn9FtpFNO4EEVfr5Dcy/uxEFr/E
         z/06qtXUA48SWAa7N4B1Otzs6FatuIUJtY6BfeVHZorzia9Sbfg61fMzCwb0Juk4/wR+
         c6sh44Md82WnEK1o4YVRgoxCiArByjF5n00Q7ZD1K+M4EwMZeJpDsFHSgy5o9nBsdmtA
         /ELb08qk8hM30/WKxq7pLvL8QqWhIkV+PoHziQ1NA1sfY97nGxbb9s4JWc7pokE7fY6U
         B7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NbE6ygLElQTTYS/K7ZqBXF2buqZVjb40e1vBsSRV3Do=;
        fh=Ha6TeYxLq9KOfxYp/u0mk6CUt101UioAbiid51G1bY8=;
        b=F8OkysdhWSTvIAi1IyA/Vn9Bk9wp5POQv2ODeojhFvCmNzhn2yYxF/gOQ70JvUnFWm
         k/6+pt6u5np6TMB+L8PswLxyLCq0R4P7DVYytPs1u6FiY0xl2P7zCvizHbpDvuCCI6kY
         SgQC8P+RdcUmWDSDUUSsUcIfs9TWF0M1Tpt7IzkiFAMEMv7WMcRELcbnUiLgiHvJZyS5
         YbBs4/i/zrIftSrhJrx1ngNSMz8/Kx6+9aY1BUlPMcZX9zW6kiSclGZS6k51XMW4jgmV
         6CiwvVA1AkD6wxh5M1BJr84nmqSrITonutRK+E+aR3EUzW4ZdK02TuuZxNp+MkA+QLOa
         WpMw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788144210; x=1788749010; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NbE6ygLElQTTYS/K7ZqBXF2buqZVjb40e1vBsSRV3Do=;
        b=KXF/DpjiBc+92Jod6X7IO0sGZW6h1nKqgC7TX4BAOP50TDO6GPt6o8/diBATIvBn2z
         hGBgEVuocqFSZAzKu95rG8Z1kXwjTAWuidmtTfEEd1EK5sO7boOicm+vbzwOcDDHtVAN
         3PYA/UMvITfPIX9JpM9BoAerGb9nl0HVnM3PqHJazzUerEBs8MMDDm1/Q1tg2sWftNGV
         abZH54/rCLbcwvuanxTrCUt0LcZfIqz+7CniXVEThyqzKk3Il7MdN5CIPM6bs8OUN17b
         XS0ByvqHQ8BQZsTCvAQDEUswbyH9TnAH+48D+kZfXM5IDpxcBl/6Aabn/awtDYckOFRq
         Cydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144210; x=1788749010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbE6ygLElQTTYS/K7ZqBXF2buqZVjb40e1vBsSRV3Do=;
        b=DgYLK4b0N0pCHIs1S1qT3gKwlhwtue0Wtcli/YMwbKspM7he4oEWzNYJhK7sw5GOpi
         9ZMTZpY0MHanlF6N3OYy51Tg2NS3+sL5L73YlQxPlzwnkTbIi88E9dU39veRQFpCXaFG
         rNYWROT6H7f4mFzcVceiHy6M+c8CSSfH2Dr1TwQdslwqPevMoyf+iYhfOpiGlzFu8h3+
         lCDot7YM/6mGP93tNG8dyEfpF+VVYtT/HrqPzidTPNmlgT9a2DJ+OHPNuLDYdj47HczV
         crO0wFyIas4YXp7De9yAKzA6mu4+vXeIMGJaSAgjNyR5QLN7FD+xV2E2N1LXb1SIjxdg
         U/Sw==
X-Forwarded-Encrypted: i=1; AKwUvByIdw7A9tOOX3cQRbv6JAVaBMfeGiU/w3L2033VrWif9oakKU4W0fOANAxTbflGr5cqHjx5tEk+vVDzNyw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++khbIL6AuP+6c0JUdnJ5pbCHxj6EpMVjfbrE+DZ7UXvbA9xbtYX
	B1Pk7HRydOpLhjwtXQYZWsQPyKo7uNx2a+3NaSlWxCfyXtXA1GABckeW5TsCVCVK7Qh39EZ9Bds
	PRcHuIdk0PAo5hJYVEaU+evGFILTjNM8=
X-Gm-Gg: AYBFou08989qlHdzqd8ySVzWdpr0qVL+oXltgC9CIS5HmVMBqLU+QPUsP44k8jEeK6S
	nA+/DDZs4ParwO4KAWUq8joB6WPYKD4l0SQNyuBWAndwShqprmfn91wVBBFMIQ88uQsxA85MjCO
	q6iEeKWWMGBvvi1nDi03mXUsu5PClydXnOwgDQkMTCGdKEhOu+p1XnXAawg6rdvn/b1Wr1hPMe2
	HpFdtg+TT9HwHkPnGBCUawjFEAPWfENlZmq47ub6VqWovvPqRPH072G31JrNC4nXzsu03lC26gw
	djobgqIbEmA4O/yrRZCwps389q2kXv/0pn5qSJGmuQNGNQ==
X-Received: by 2002:a05:690c:38a:b0:81e:695b:585c with SMTP id
 00721157ae682-8678f0c3792mr241247b3.4.1788144210009; Sun, 30 Aug 2026
 19:43:30 -0700 (PDT)
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
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com> <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
In-Reply-To: <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 31 Aug 2026 08:13:19 +0530
X-Gm-Features: AcwNN1XmXTP91gt09bDas9PoVw9lX5EEpGOPuilZRVTJETaIpy2y2cTeB3EQiZQ
Message-ID: <CAMFFDGi161c0a8CX4DAaRzc66xTG2oRZ7DOgsG7pNRo-YP9-cw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I do not currently have the PCB layout or RGMII trace-length information,
so I cannot confirm that the PCB provides approximately 2 ns of TX delay
but no RX delay.

My hardware results are:

rgmii negotiates 1000baseT/Full, but RX traffic fails with CRC errors.
rgmii-rxid passes a 5000-packet test with no loss or RX CRC errors.
rgmii-id also passes the same test.

These results indicate that an RX delay is required, but they do not
establish whether the TX delay is provided by the PCB, MAC, or PHY. I
therefore agree that the traffic test alone is insufficient to justify
rgmii-rxid.

I have contacted ASRock Rack requesting confirmation of the RGMII timing
and PCB trace-delay configuration. I will wait for that information
before selecting the phy-mode for the next revision or making a claim
about where the TX delay is implemented.

Thanks,
Prasanth

On Mon, Aug 31, 2026 at 1:53=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Aug 30, 2026 at 11:50:34PM +0530, Prasanth Kumar Padarthi wrote:
> > Add device tree support for the ASRock Rack B650D4U BMC, which is
> > based on the ASPEED AST2600 SoC.
> >
> > The series adds the board compatible and describes the BMC memory,
> > SPI NOR flash layout, UART console, and MAC0 connected to an
> > RTL8211F Ethernet PHY.
> >
> > The MAC0 RGMII timing configuration was validated on B650D4U
> > hardware. With plain "rgmii", the PHY negotiated 1000baseT/Full but
> > received no valid packets and accumulated RX CRC errors. With
> > "rgmii-rxid", a 5000-packet test completed with 0% packet loss and
> > no RX CRC errors. "rgmii-id" was also tested successfully, but the
> > additional TX delay is not required, so "rgmii-rxid" is retained.
>
> Please take a read of:
>
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bi=
ndings/net/ethernet-controller.yaml#L287
>
> Does the PCB have 2ns of delay for TX, but notR RX?
>
>      Andrew

