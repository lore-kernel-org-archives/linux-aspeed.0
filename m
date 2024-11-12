Return-Path: <linux-aspeed+bounces-122-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24846D32D7C
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 Nov 2024 09:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnhPc5frtz2xFr;
	Tue, 12 Nov 2024 20:46:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731404772;
	cv=none; b=CjwgZHG+6nzwp6uuaMCdqRg7SUKuwBoAMxhTG2D+M+fgVKAay8/p+84KwG2jHGVokPwqUYcAG+Aa8i/OwMbzdZdRdaIVG+zSd80Ng82t5ogOZH2nO4gffzIITbVOIFi9voZgHVe1OCwm+Xmohg1oW7TJJo+HarXSrLAuOOFUocCuwkXsDHcT/W50tmUgMaaXT8zpAsf+Z5UVl+V0+ajItPcG0tkSwhoanXW/rXfNoTYhXLhAo/nA80gRoo0bOoGz7/VxZFNVZZf9+BxTIS9CVoz06K/TTFlc3mTbksbsPXZQrc9eNGV7vIpqC5OY9l67t02xoIXyUB35AD7S9zbnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731404772; c=relaxed/relaxed;
	bh=Kn+8aJWTkqwQ5EGfRTZpllEjlS0gFyQTELc12l06XLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyKCbXHAYsyzmiP/sOX0bYxd/HW03YgrqUf/J+EGj2dI26g68UFLGoCst+WLCQegJr8tmviqG0KCp50DXpHotRXokbBHGbPriC17yXJN9mmsTTEKNRZVWOhJClyxVEkvNwxS5dRLsJcnsJ+YEap+Iw9CFivkY+axtA3B2t37dn/d97Q7Va7RbXMNGbCeINkx+M3aa+1WU/nqfqO3kpw+iQydnN5KHTkUSQdtSnBtvcpkLXX8yW31BLayYuGOrR3F72tvPbkoOHiftX1G+bxM/y/dvKEADVl72m4FO2oRyegPYkOIW+bvOUPwOUuxN2jDCE8G7/OlkggCqDiBkz2PIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k1RO6zEY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=k1RO6zEY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnhPV5tHRz2xBk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 Nov 2024 20:46:05 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-37d447de11dso4049742f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 12 Nov 2024 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404761; x=1732009561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn+8aJWTkqwQ5EGfRTZpllEjlS0gFyQTELc12l06XLU=;
        b=k1RO6zEY+0XN2TF+eDg19dcGOuM8yBBTVeOJtO+Yzn0ZjuBmaQkigb/gFD57cgKExr
         NK1qWu+RyukkjRVN1p/+D/B/mWjvbfKB5v5DREbplLngiCUc33OuKTx2nNmtaAY7vFXl
         01pcq6ZWNZPuM7a95H+ljFYZUUC1p83oj36GMigQYp6Le+txUibSEzUcxQjlry/dYxTZ
         OAdG8mjYZsMNGM3WE0ZiSDeRGRMLjlxM8tOZqwf7SIopl65/+DCSl1VAO80ZcsJuKF2e
         aCTura6eB3KX0POKfiVs0efsmra7n5oVFWaNJZBhVlNeJf0Wmkv7wmJl064Lt+ECBEPm
         A4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404761; x=1732009561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn+8aJWTkqwQ5EGfRTZpllEjlS0gFyQTELc12l06XLU=;
        b=Pz+NJNWfgkefL09H/clE5AYyDFGu8s3Sc38ieRaFDCyHCdtlZU1zXd57Wb/QyW/37Z
         oAH8Y8Zyr5r+m1rx5EI3NvSt5agtUW5sH104yKfsx4pX9WUzplNi8s9TSjBg0BzPBxYM
         Q1uXuuVfs4XgvqJmXhNvP3gRr05C/4Bljft8D6veLZq0xXoFpxbaNYXYShOxpX2WA9rV
         zVZNT2BCK+RsSu+FUTGh27x+UYusWZHs03estzsLqQVmwcZuog2wIMYujiStHrFT5bP3
         WP0PToOij8SJ+hGH05XIEepmkbFa7rXc4gDeQsdfWP9RgqWvdTxRozxBJ++2xwMwoamF
         /r4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXXKjHv2RbcJ4LyZub+SxMMCJnAeeAywuSstcdWRleaS34aTEgtl6RMSih1NzTdGUVepkmcuI/P2nyMjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzqfVA8O9uY7hzs6wUgXJT1pdAHn4br3jIYAiOrw1Z3L882+pYz
	ob6x7vXsIxP0bITEhqYN3ipqBhHVB84c+6rvzG69FAHrPwng9jbmmqkrn1BEKf9WgO0UOYRreNS
	1mwqc4XGyJkkfy5ojSqgOQjsk0nM=
X-Google-Smtp-Source: AGHT+IFPzNA/ykyop8Pr9VmfZCzUea/dWGp/PCJjjDw1YLiQF+EUnfcDBl+zIVNWxL+YF7MTzG6Ojpszf6h87p4+fzg=
X-Received: by 2002:a5d:5f48:0:b0:37d:498a:a237 with SMTP id
 ffacd0b85a97d-381f171ccc1mr13389793f8f.8.1731404760474; Tue, 12 Nov 2024
 01:46:00 -0800 (PST)
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
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
 <20241111094349.2894060-4-peteryin.openbmc@gmail.com> <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
In-Reply-To: <434b2dab17050643badc60c50b361153631b7cdd.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 12 Nov 2024 17:45:49 +0800
Message-ID: <CAPSyxFRC-VBVs4xBFnkoBNx1jNjr+cJ_CztmgCpMzqtjYDCVbg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:53=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Peter,
>
> On Mon, 2024-11-11 at 17:43 +0800, Peter Yin wrote:
> >   Add:
> >     "ac-power-button",
> >     "asic0-card-type-detection0-n"
> >     "asic0-card-type-detection1-n"
> >     "asic0-card-type-detection2-n"
> >
> >     "cpu0-prochot-alert",
> >     "cpu0-thermtrip-alert",
> >
> >     "irq-uv-detect-alert",
> >     "irq-hsc-alert",
> >
> >     "uart-switch-button"
> >     "uart-switch-lsb"
> >     "uart-switch-msb"
> >
> >     "leakage-detect-alert",
> >
> >     "power-card-enable",
> >     "power-fault-n",
> >     "power-hsc-good",
> >     "power-chassis-good"
> >     "presence-post-card",
> >     "presence-cmm"
> >     "pvdd11-ocp-alert"
> >
> >     "reset-control-cmos-clear"
> >     "reset-cause-pcie",
> >     "reset-cause-platrst",
> >
> >     "P0_I3C_APML_ALERT_L",
>
> Rather than list the identifiers that are already contained in the
> patch, can you please discuss what functionality these identifiers
> enable, how different functions are related, and why this must all be
> done in one patch?
>
> >
> >   Rename:
> >     "power-cpu-good" to "host0-ready",
> >     "host-ready-n" to "post-end-n
>
> On the other-hand, explicitly calling out these changes is helpful, but
> please also discuss the motivation and impact.
>
> Andrew

Hi Andrew,
    Understood, I'll include comments in the next version. Harma will
be moving into the DVT2 stage,
and many of the new GPIO lines weren't defined in the POC stage, so
I'll add this to the one page.

Thanks,
Peter.

