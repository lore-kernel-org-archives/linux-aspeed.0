Return-Path: <linux-aspeed+bounces-4759-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A700C5B572
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 14:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ7xm4Z4Gz2ySm;
	Thu, 20 Aug 2026 00:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787149196;
	cv=pass; b=PoYCsfW/tuEvM30+G900a+6Fg+XtwttfMghPsO2PpSx9gw36Qs2SoSUcacVqiXqP1tuuFvfM1ftpfTTRXQgBvhf5DD+7mw6ifzu30qZ3Qr4Ai5pdQVLyTCuQws5lKk84OTmzYqR9QuRcZ14Xjo/jZThFzHP9Ll0hyslaIeoOhQXk/87R5ImHKZZDWYw2FUfgSe8Hd2EZxapTIicHObCxt3z+WWFHoU7HXfmn/YIlPkWu6HRrw5nabf2nsry75sU1BkHU4jMMswmyCGtg6XZoYs+WFFifOusDn8y/fmEZ35sR06Mz+7DpoKrmNCJbvxOZpe/sdIbq0iIQRoLTBYdY6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787149196; c=relaxed/relaxed;
	bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LugbSInaQJ9s9GOpk2dL9R/HfQ8K0KBnUqmnInSt8byhBJHNmJnQ52e9GA3jk5mcAYReFeFwt5Hw5sets6EyBCjQ/fhvSStTcoeEB9Mfs6zKoLON9GWt5wZN9/MFJKrQdtsmDVlLcd1mjbV7EAkuK0nzkh6oVmU1VWenNtbpdh96GgWqFUM6UdPdsFGFbiKOBWniVOwhGdKjD5icNw4Bey6Vv7rvsTNKKNGq15RxR9siMZrgIEVTdjMtZAZzv06ZEH/EaZjYHjpLJbGMUm1TpKnrtTuwR9EAYP5sOeV6d0Gy+FfgoxQ36eIvdBM6w9s+V9PXd49RPOVCPONy1Ksb4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BLOKNkY9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=BLOKNkY9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ7xk2jHpz2yRZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 00:19:53 +1000 (AEST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4998590d392so10178895e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 07:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787149190; cv=none;
        d=google.com; s=arc-20260327;
        b=BK80hTpRAVcs084yYDmG3u3NLkNe+2jMgPO3uxDxK7aTuSVmWKOKZSTYlFS7lfWDqb
         O9vnLtyaoJgEaI0IwOcvxYViElhWUiW3dsnw/LGcXsdzro5k0YNgyoEx7Gqs/g/tKKVH
         03Mo2BdU8VjcyzX1IIdSOZfsGVKu2i3vDEjgiNjAplRvXfNOMURPokzA1c0jltdJz5Fd
         lyAsWphBGFsfzlnX9hUe4rTTwWfcU5dFlbJGT0UNyB/UTVXUoTgOVQw12AJppU5h6ZCi
         0FrIhhMx4qpA6ng1OObkYyz/P413V8tBa43psDvzv46/vxrNLAOfymf3kwFWN2MpRB0a
         ZliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        fh=c3E3bUpFnfBRwNBBSEoFUbnBI0XofgPvf9JkvkXlnCQ=;
        b=sXHSGkQBZlfTkdXW8Ks+ObjB973E1AEx7Cs8zDEi9FE2+RVmu7htGphIcRM4zC3H2c
         KhePNz+bS0GPvX4KlN7d3szOOVvkEJnLbpusyegZuXyUKvLiS+O7D+qJOTDw1omflBD2
         MEXLUb34Ry4wtwIalqFDG48N56Eg4GPHfNpDMsdyqvl9r8RWr/ullbdrx5Tg1FfCSIlV
         UTVQJ4n2oiQqzh45B4IznqCY0tevRv+nHuWoUok4fQy3dZ5egklAAYlJvQHKfKtuVCKP
         ommSmI0bgCKuF0rgf0nyolx3VCXcZ4pzmlniwiPnTb3SG21xRCr8P74dbXBPE/e8wMAe
         /20g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787149190; x=1787753990; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        b=BLOKNkY9jNSwEoNwLYd194b3h8bQUPXkaYcSvyqiTN24mTvrlVieIgSq0k0GNWtB9J
         SR6r7KKsDQKAw5rp+boZ9dcYh5KlBesQ4ScyYx7f8otJXU6a3hII2a7wNGCXm+v2tZIL
         /P3ztDxSEHo8uilsqP9k+d8I46CPpqI1gt3g5+8vla/m4O8xYm2VyiaAPdo6Y5dwZgQO
         R6ymg2cy4NZv8m1kzMc+6GfvhJjk9XjPE17GA+oxZAql6EHBcFg6SBCl2zbLVaJ90VIT
         Oo9yS/h1LMvASe0Z2FtemEOMUVPKch1VEzgNVNRItiId0Sc2kJhwUMXq/QZvOFCvWReB
         0wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149190; x=1787753990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MeJKUhVwZjDQ5ldC5TBiCaKL9cckQ2oDXCu8SH2HVSc=;
        b=Fc26Zkjn+TzGkFSY/RXVsKp6LDAm1j7upLQW501Hg+wqUGJKBKvrRg+mk767QDp7XB
         QEyoiRH/LqmXgHLLA7T8Srw8Z7NVTo+Ac1pauu4Ay6I9FI7MGKW8+cnO1v2t6ak1Ildv
         K6te/RC000aWrV4t7MH2M+XOs8gEsQF5LIK6lHyD8BZMw+Z+BYXLq5VAJvXF7P8sCjiy
         aQOshWMDbEspPVneYN6Pk+Z0fbZuOJqf4PhJOr8eMwuYHfJmOsTnJqPtsejYKkEElpaM
         73gIT7an+nB+ocqZm3RR6frLFHyvLozpBS9u6TKxUACYW2/dMFA/0EIMEsIkGL18/D0p
         mNYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY/JF/K/ExTomPQIH+3VPCNcajZ2jwo6iZe21VbuD8nm6oq/5x5a+24qsKpNjiLl01GhrZjjh4u/8E5BE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhRigx9w+ti3YWK4l3mwXHIfhVFSznPt1JBUevkdGepXQlmdAt
	oy5z+iHGWmHdO2O3PunfVy/JsdHV06d7BlhN2GSRGHpqQWPuMMKF1PIu0aUo+J88uBrQkfghA6o
	IsgbZGubD8zofgJgKRzYbQ3oeTpjBprH1zCfaOpM+rw==
X-Gm-Gg: AR+sD12NV8kabeKAGGWU5OrO/7Xocq0eXrJFS2C6Cl41xcgRHOZO07f+TObWUTtIzEw
	WMO0VptxcdRSQWjRMngtFta4zZ778mnL0XjJPLbGDlTWiTPZdH8aOcL24smVx/riR/tkAFBS417
	RYWv+qBOkepe+drUP1PbRKTnna7MFQlACqt4FyMwWwxWROPz5cQgtwU5UydXr4WSskdiNLoSkQh
	hJ1lrMOjaEqJHM3XXRvbPNDzimjU7j/F2a0B1oezQ43fvij5wb+sH6Hu/QhdSq2oeS/HytXq4v7
	wcU9hEPtZ0Led7TChF0sY+SFco0Mf+f7xQJUEnZQrfxbkS5pUPm0VTZnhB3TOedisZ5oWKp5BJ+
	ZLn0RcT05PjOKS9Z+M4RvF8+RxDK27kqBA68=
X-Received: by 2002:a05:600c:3485:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499aa19a3b8mr105118355e9.4.1787149189928; Wed, 19 Aug 2026
 07:19:49 -0700 (PDT)
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
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com> <178714815308.32179.15619694497271022262.b4-review@b4>
In-Reply-To: <178714815308.32179.15619694497271022262.b4-review@b4>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 19 Aug 2026 16:19:37 +0200
X-Gm-Features: AcwNN1WSp5z3ykm5DhYgUXUEaifqr2FKPqOZiTmJSVGHJcNVXhm6Z3n9CL5gr0M
Message-ID: <CAFi2wKbvOX+E=nsWuVJj=_xQZQm=vCA=qPWwzgJF2oio2ov_UQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device driver
To: Tan Siewert <tan.siewert@9elements.com>
Cc: yh_chung@aspeedtech.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
	=?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tan,

> > +ASPEED PCI BMC DEVICE DRIVER
> > +M:   Gr=C3=A9goire Layet <git@gregoirelayet.com>
> > +M:   Tan Siewert <tan.siewert@9elements.com>
> > +S:   Maintained
> > +F:   drivers/mfd/aspeed-pci-core.c
>
> I think it'd make sense to add the linux-aspeed list as `L` here.

This is already the case.
The following maintainers and lists are set for all paths containing
the word 'aspeed'.

From the MAINTAINERS file:
```
ARM/ASPEED MACHINE SUPPORT
M: Joel Stanley <joel@jms.id.au>
M: Andrew Jeffery <andrew@codeconstruct.com.au>
L: linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L: linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
S: Supported
Q: https://patchwork.ozlabs.org/project/linux-aspeed/list/
T: git git://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
F: Documentation/devicetree/bindings/arm/aspeed/
F: arch/arm/boot/dts/aspeed/
F: arch/arm/mach-aspeed/
F: arch/arm64/boot/dts/aspeed/
N: aspeed
```

From the linux kernel doc [1] :
> N: Files and directories Regex patterns.

[1] https://www.kernel.org/doc/html/latest/process/maintainers.html

Regards,
Gr=C3=A9goire

