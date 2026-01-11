Return-Path: <linux-aspeed+bounces-3280-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7411ED2502E
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 23:16:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqBG16jfKz2ykf;
	Mon, 12 Jan 2026 10:16:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768166888;
	cv=none; b=dk4tZeXUjI31jAKOp1hgcaYV4uGR7JffkwjVu0SAq0QOCIYW6PZceZ1emSz/pvRi1n9oltqz30qPh41IPyh/EDeXZUYt7U5305+r8YPAqyaWT/Ovyp8ZlLKPhYTeNFFIOMozRWxdyT8robRGPB41qJ9Jq2oreAY6/2Eyr6xDZ29g6uX+Y2MS342g5bqq/7BwmtNWjQxacw0zIliJB7VM3rCpwvioFpyg1YVkbrMjzT/2RJFb1R6icb56CCw6cfCg5Juk/TYLUHqifN1oOxO1P+SMjtdPxH9ArY9XSJJF3aKPw83OdAhtUN9HiBPjP6Xfg/tpRPlw3U69XmOSplgitg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768166888; c=relaxed/relaxed;
	bh=O+La3CIGRSshVXzJJV6Ws5h0oOhl5eEMo2EIxi5DDGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMBZuMPpC4+1spz/xRMXlpQwvy7/J5ARYFNnzkQKUgT3H8/v/nv4AcMlpE1aZPRl4YT491+BFP2Z+PXZRzRIkxkcBloOZffBdTurMJ+BjnAgd3nwYOIjO+Ti07sTTR/Xc1iN+nFba9vaK11JG7EHR5Q3CVsqxMQ1AtQZGUOwvsglEMqj6yM8WVZ/4cyoZPj22UFA5Xw3zc67bhWWeEp4LkCvZ8IHEmdJZNS/iOsqXpzn3qCYUInC1DlXsY5bKOAy6zwoLQr4rpewslF+9D1Yu/tRBjOq7y3z3/DIiAdfZZgXl1wA6OHKnK3g9kZc4IGpf9Towki0Tf8ov/uO1OKaYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WfW5XFQu; dkim-atps=neutral; spf=pass (client-ip=74.125.82.46; helo=mail-dl1-f46.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WfW5XFQu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.46; helo=mail-dl1-f46.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dq7sM0x9Rz2xQr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 08:28:06 +1100 (AEDT)
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-121b14d0089so6202007c88.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 13:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768166825; x=1768771625; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+La3CIGRSshVXzJJV6Ws5h0oOhl5eEMo2EIxi5DDGY=;
        b=WfW5XFQuG7Y8ygecBOddkngmWcSSVCBHaOXDzeHPuysiz3X/xYivY2EE2/AdxV9oQu
         gBNfGFUxRoDFvIbTOuaH1QJTpR3c1aIPDETfnwCWUMoNV9aYWvaJyVi3lIL+NmRAwD/Z
         XAhTcrrr1k/l0zlxo29TKMtugJlCKYwbqSoziXBgMF+S6nYrm8qkW0TsB5R68HDGNmSb
         x03nqmZRiO+rkr7iIT4xnhRoGxClQB7EHFbz1h1JBoLD19WqBhUU5Z0fGTOPUpaeXO1e
         7ZhXcnnKfdo4maXR02osXB43MRM4xTfT1E4jizv/aSSkTz5pz5mz/xbhuaOeZjotj+3f
         DJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768166825; x=1768771625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+La3CIGRSshVXzJJV6Ws5h0oOhl5eEMo2EIxi5DDGY=;
        b=JnS88IocjpN2t7/0VP4yAJrGsDpQ9uiVh99NAYICAG4T/qxVAU2DkymNc0VR0Qbm9e
         cCdf7fNGYzlLds8N2/v90GO58KMgcIa0NZPmdBNzp25ekNQH9hccibgsVpFPQzoLe55s
         TfMBhNV9AGIrvAkCiSb01lwt3Lv6pkaXUUbYiRI/vk7rlkSM1wymR58exzUhY9zeng6+
         qEqHL7al5L73x69AcoIUrkHENjTPzdU3A22Rwr7fgiWPAEmpEXKR7AXhiDQNe6eoFPSu
         SdVJaAvecNdtm3sDCJzKy2Qp/ig4FaQdy2V+8pJ2VPrvm6MfJoZzyGBKV4qFcjrspGiy
         /bRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx8DJYNrFhhKWEWu1XjVSdH9zptcTOsCOxLNjTepaWN7O7wP+uTr529YF1xnyJF5XuE6RfjU5SP/FP8aI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyg1TnxYDMkXP24/4OiadTBjV+HGE2m3lNBE+fjvZGO4JIy1/Jg
	DH8VvFYMnt2VpqYr5mx7IvXUjf+DMXiLBfzXMBgZqwDefPVJUi1FYkrfzPN5qrywrBRzSQqSM+j
	T97HzfR8mIiS5WoKT+ADRRycyT4rsPaQ=
X-Gm-Gg: AY/fxX5OdowjLKNX6peyCNGIZWn3OsrG2F5BW0GSMrT6x9UsS8xkyHn4vbq+fc0H0jD
	arLTGQfcUoiEpT8TSHDLAp5E9lCq6DwcZ8hvDClFjtZm+2UO8G+ngpQ0tktF0nmnXgL+5ETwhnf
	mHGTiEcpUTgd8RQZIR3cpUtA9rVF+FsLeQKo6SxI4v6axtH+t8o/X/djp3Cp16vylx313Yq6vrN
	QzFDMw4ZRc613ArT7eeutDN+4TICUF+4wElvuDO1Ze7Y0HJm1/oE0ZYENQNnlFt+RgXks9mdqQ2
	SR244ee6SE4o7UeyX2I=
X-Google-Smtp-Source: AGHT+IEAIkTtTenYTps//RIeNMSHypd9h5mkG9ym0bXQcjZBxIqbQi188jjy2QtOlW65luwAbZQyPc1Ub9a0FeUef3E=
X-Received: by 2002:a05:7022:b9d:b0:119:e56b:98c1 with SMTP id
 a92af1059eb24-121f8b8c1dcmr15280403c88.40.1768166824499; Sun, 11 Jan 2026
 13:27:04 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-3-anirudhsriniv@gmail.com> <fdfb7212-5133-4cf4-9448-15cbbaa34eff@lunn.ch>
In-Reply-To: <fdfb7212-5133-4cf4-9448-15cbbaa34eff@lunn.ch>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sun, 11 Jan 2026 15:26:52 -0600
X-Gm-Features: AZwV_QhD59iuYK8Lvi1649SQz_mf1A12Z53MMB7xc4wTeA0B9lLvh3wsy_Tx2eA
Message-ID: <CAJ13v3QVVC44XD1W-4t_m7Mfv8L214s2T62CyDdJTggX6paZpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 3:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&mac2 {
> > +     status =3D "okay";
> > +
> > +     /* Bootloader sets up the MAC to insert delay */
> > +     phy-mode =3D "rgmii";
>
> There has been many discussions about this. This is broken, 'rgmii'
> means the PCB adds the delays, not the MAC/PHY pair.
>
> Please drop Ethernet support until aspeed fix the broken MAC driver.
>
>        Andrew

Understood, I will remove it for now.

