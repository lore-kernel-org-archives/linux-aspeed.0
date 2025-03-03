Return-Path: <linux-aspeed+bounces-916-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA8C282D2
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 22:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6DLg4Cdxz30Vm;
	Tue,  4 Mar 2025 09:41:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740991558;
	cv=none; b=ApDqL9tKXgo6Jym6VDDsfHYrVoca69haKgpTJib9svwNQvRjxe3G7iIxBKXE+m2OAVMre8ykEus0idqfoQ1BJAFlGeiZNxnZ0cbUsnmpwXTZ2NCo1HwKYxMh5Mt7Aop0rLsh/C0RoDl5Llp0Qi9tWcnTPnIEhQvTzYOHqwQJI4Fa/HOH9MKh8FEsbxvM6lsBk+Ql2EhmZAus7kdXvbHrI7J91AmQjmpBDo0eStShwmIi9qEpUGq8vmpK+gMG9c1pLpA2SHev2x9/S0pWIjzTiyaHO3+I5IkNlq8WUPLbBiKJkL3x2UqJiDqNfQCAHdp0bRtZOLpb7jsshew3Sh/WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740991558; c=relaxed/relaxed;
	bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=erkL/S4jihObNnmbSbIgd1s9O3qP85gK4ApyLFyIjLomUgh8aqR0zw9w4NMx/bSHHVbyCymA++0P6wINsZIopqbhkWew86otYgk5WOOC0txGxI6mcIK+RNadaYolUKRN6zV/Dzv8LCu+vqHO/HJpYIDY7JC+4bOYBhViVVx53LabQEoNrMSjrHfSnX844X7WILj1e0jouZjTh3ZQWE2SStROkmTfIVemd5BuAlJp4PLzYEKevITt8U+nfbWHOhh15df/WcTL6uffmFR9+GKSMKr8ZgM1cOUyUTWNhGwAOtv6Pa9gP1nCHldfs5KUHSmLYnYDm2/iM0iE+srS8oCWOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wZeRyVNc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wZeRyVNc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z5spr0rwtz2yDS
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Mar 2025 19:45:54 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-43948021a45so38086375e9.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 00:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740991549; x=1741596349; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
        b=wZeRyVNcEf7VWEcZ8YCYyiWZqrL7ys6ASAo/F6AVphpJnEYjb+rUYTdMjCpSDoSw9B
         kLJo71YWcTcWcBdoeDDdXDQXtuA1EBN6+KTs0jIbbyjmJXQVgg4WebqHb6Ymap2lch8d
         H2kTygLsLcgxlWvPN7rUogT5sQIqXuakqYL/NMKhIDIKRCdnoZoGsfgpPNdEQwdg1mwp
         W07OAWp0O1ro+YMb4AtPnD2BLUBNZvjF5mMWc971Zy5rc7wnBGZ4P0h4PirdtsWTmaO1
         qXEYetqJcLyqMlQ1NFdtHa5JJLYIQZHmGvCiyWZDXYAXhMgdzbwxvwMBYKQ6yDw8mW0F
         AQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991549; x=1741596349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
        b=AkNDa3lQu+0xLzqP7dSi+0dThKvhAukP4OGrhUxoFnrsxg4jsK3edq2Jn6yzjxSscs
         t3Gxj8N0ZVGNbUardFxqsOhm2HL2Ian7dLquueYiOOloDCgLuExHKgvBpLSJLe6BKDwh
         QnYfMK+zCl/PsBheD3yEpO534sAO9i0NBRJpGJDydlJt93zQB0Fl73I5/tDmprog+m59
         I0myoXd13E4hij9EUcoAvbIJOVQJ75/mxnHzJ8pq6xUjOgm2lhJJxgkW43FhSyeYhUJy
         fmWrXKQqQ6Y2VOsZozrrGGxDzDVQ7W48RoVWp8pCCNFnk3tWEmVdwG0dlIO9lHj97bo0
         3XJA==
X-Forwarded-Encrypted: i=1; AJvYcCXJeDKoc9kjdjTYE6RVuyJpikq50c4/G29DvsOlWYym6wdwgb8Jj4ggImkpTDuMwB3PWFqqB9MeHvX7bbg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEyVCGaM1S0VcwxT1LHE1m3vW78GBBmD9jvEAUjW5QSEjALQKn
	1kji3Z29+54DVLfEW9Fe1wEpAXmgDAB/fn1R3SoJO0miVswLZFHDB9vsW3DHS2M=
X-Gm-Gg: ASbGncvonyQI22zI1pbQxf9BI72NVL4PBOeNMRNn2XnCrjeKnM/hAuAcmlnDwnwMt1Q
	e76j8KenDU0svvp4oyae3NOT3RKD9ezP09uNWIT5IizRFXCWeRMz7dKeyfFm2SiNtwdZxFRbD5s
	sIx/tya/XczYQzqvynro676/4/4nvruhdgdmPMOA2W5Z8WtbDRHSgTgVSQzDvsXOBuqhFTEFJbO
	bY5g3GSV5M8XEVELNyr9+EuNxfnJUYh1AEprUwdFuAUjldX4kcskHoZ/WFgQd1kXYO1zsqqtbdA
	Xz3fgBPnkG/i2dYtxy1mm48bbSOdwcX9lEsEHuR8ZXLCw+Py
X-Google-Smtp-Source: AGHT+IEQ5gIerplrLBCNz9iWi2EjC22riC6x2aUD9LPOL3RMv31foO6V/nmZEr2WkFVBKnwbDjXW6Q==
X-Received: by 2002:a05:600c:4e8b:b0:43a:b8ef:4dce with SMTP id 5b1f17b1804b1-43ba67041bamr112726745e9.11.1740991549553;
        Mon, 03 Mar 2025 00:45:49 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm153130965e9.3.2025.03.03.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:45:49 -0800 (PST)
Message-ID: <4d0042850eb4d9898559b56505291c4e849d44c5.camel@linaro.org>
Subject: Re: [PATCH 00/18] a few rtc driver cleanups
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Hans Ulli Kroll	
 <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet	 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  =?ISO-8859-1?Q?T=F3th_J=E1nos?=	
 <gomba007@gmail.com>, Dianlong Li <long17.cool@163.com>, 
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org
Date: Mon, 03 Mar 2025 08:45:47 +0000
In-Reply-To: <20250301203658839d5482@mail.local>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
	 <20250301203658839d5482@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
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

Hi Alexandre,

On Sat, 2025-03-01 at 21:36 +0100, Alexandre Belloni wrote:
> On 28/02/2025 14:07:13+0000, Andr=C3=A9 Draszik wrote:
> > Hi,
> >=20
> > While looking at RTC, I noticed that various drivers are keeping
> > pointers to data that they're not using themselves throughout their
> > lifetime.
> >=20
> > So I took the liberty to drop these pointers and this series is the
> > result.
> >=20
> > The last two patches also convert two drivers to using dev_err_probe(),
> > as I looked slightly closer into those two. They don't exactly fit the
> > general subject of removal of unneeded pointers, but I wanted to share
> > them anyway, since they're ready.
> >=20
> > All of this was compile-tested only.
> >=20
> > Cheers,
> > Andre'
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > Andr=C3=A9 Draszik (18):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: max77686: drop needless struct max7=
7686_rtc_info::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: s5m: drop needless struct s5m_rtc_i=
nfo::i2c member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: aspeed: drop needless struct aspeed=
_rtc::rtc_dev member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ds2404: drop needless struct ds2404=
::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ep93xx: drop needless struct ep93xx=
_rtc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ftrtc010: drop needless struct ftrt=
c010_rtc::rtc_dev member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: m48t86: drop needless struct m48t86=
_rtc_info::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: meson: drop needless struct meson_r=
tc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: meson-vrtc: drop needless struct me=
son_vrtc_data::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: pl030: drop needless struct pl030_r=
tc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: rx8581: drop needless struct rx8581=
::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: s35390a: drop needless struct s3539=
0a::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd2405al: drop needless struct sd24=
05al::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd3078: drop needless struct sd3078=
::rtc member
>=20
> My main concern with this is that as soon as we introduce irq support,
> we are going to need the rtc pointer back in the struct. But I guess
> that most of them are old enough to say that nobody is interested in irq
> support.

Thanks for your thoughts Alexandre - I don't know the history of
these drivers and don't mind either way. I can drop those patches
that would require reintroducing if irq support is added in the
future. I think overall you're OK with keeping them, but please
let me know if I'm misunderstanding :-)

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: rx8581: drop needless struct rx8581
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd3078: drop needless struct sd3078
>=20
> I guess you could squash those two with the previous ones touching the
> respective drivers because you are the one removing the last remaining
> struct member.

Will do.

Cheers,
Andre'


