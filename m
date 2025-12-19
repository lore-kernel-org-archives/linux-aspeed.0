Return-Path: <linux-aspeed+bounces-3176-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71CCE6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:54:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFWk2gP7z2yFW;
	Sat, 20 Dec 2025 17:54:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766133616;
	cv=none; b=Mw6baTUXubUz8O74vqdm4gp6aWWTSGCjURPXKtUt8kQuDDDjAn9dNlyZMK9gocc1BsL1U32pUJ6+rSl/FqDg2/2UVbtV4vmBFaOSJB+O1yXqvsxhaqJzPMZgtPC9FPet2jc3Ri6doAZ9Bf8zWtFJr0qBrpHyiOEhBazIRawLIdLbmhc2iiQwWfJbb9EILoyUhi7oATRp3dJ9XYpIFsgGCfXSEN3VKMSH2t+K2ka5/XrqfiosjADpyxUIiGK+JOFevKji6grx6uk7s4mAOS4eOckxdA9Z8ZgXDMknSKNTO3CqZITsEnxSK4Q6C2RzuNBko5IsTWxTbd5p986VwKahtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766133616; c=relaxed/relaxed;
	bh=XHPtjrQR6BGiqK2vk4UpNJZFJRTk/Dln70vYvB9yRis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isJedBiacPi8dIdXViYB6iLl0AUxs9uPWkuPFg83yu7TxahyY9bvxK+0rJ/vlch+TGjQGDCTJ1tuEfqeqLGIB6fRsIJQ57BhxxBk+GQ15wWB8Z7aGG7QScabl9T3uXFIvcV0rPOphULEVwF0k4XRM2xr9JOPVqBcGQZIp6vg1PRDFSu3dlLukQkfGXl6mYIneq+7isHWBVuUU1J0qAP52dQPY6UvKzxgkeOVFBzj0vCNpqixiqc3jAL2WXOgPXYC52e+t1Z4N34/EX8ZlOYshpWVh/PZxpYMlFyJpC/CBl4x+sgPbJ0RQSzUWMwOJMphLNQT2YcrOE3TtyZNlhAncA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iqwQsDDr; dkim-atps=neutral; spf=pass (client-ip=209.85.210.173; helo=mail-pf1-f173.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iqwQsDDr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.173; helo=mail-pf1-f173.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgvz5KcJz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:40:15 +1100 (AEDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba55660769so1304459b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766133553; x=1766738353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHPtjrQR6BGiqK2vk4UpNJZFJRTk/Dln70vYvB9yRis=;
        b=iqwQsDDrStFBnxvEiBMde2PIgb08gMAODM5NTTrB8gy4LrjZk2Ei2wLnjTKNlBv8SY
         c7TxBhkHCRwPZXeQ2/3uz3ICS2u47ZDN3Ul4nf14Fd3mC/buFF23c+BnQZxTcuzFTk07
         K7lkwJ0G/E1Ux2lFz9TRbUeP8AcXvclfPw1qVrv6dvbW9ygpgn1U5WED7vHaw87eayoq
         G4FLf+EiuJoESdJUakVgPI7oIqVIGrNO3l2nwbDGHiNIn9ayzSbrUqPu6ak4ZycvUOUK
         +voEeuCrO4AV00inqbMmrR0ouTGX1S6+5OBGSgC+5KDpqEULYyyZZdUqKwfvr/J7kGp7
         yOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766133553; x=1766738353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHPtjrQR6BGiqK2vk4UpNJZFJRTk/Dln70vYvB9yRis=;
        b=EG/XDd/hS63+sOhCtIEpW5d2LcdAuWT8LnHWQ+CNQLCj4iAWkAYBpT0TWzwVaJVLy/
         EeZNDoIIOEnlsW5oHHWvPbeynnMhpUDCH/8pH5LgPBCHRH65+TVNyjZNNNac//ibfyAT
         WFjHIJxknr4lWgwn7Ph3rCyg2y5oeAI2a/bfPWbC1RSNQPMc3F3K21dl2nn5yeSiuVqi
         R2Jynwt5Tpc6T/q1iPcIV7uXnSpnnuT1a867ZVhIscJznzMsFjJiGvDtFSS/rmuW3M3l
         nMf9Xj8HwzxbT089E9IaIpQXFZZeJ4nsaRVTROoPyUtIffK31/dcgGTaiVokp2UoTXxk
         Qp+A==
X-Forwarded-Encrypted: i=1; AJvYcCUg+2Nw2fTEa2IvvZiQ6J7jLu8gZs57gQnNDNCgx2wh37WSj0BHwUmO5akZHevJzkfgNDsr3bGpWQjXiMQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwZwVasxbR8vVvEye/v38hfei6JMwVjqplrWnl9siqZr6sCQd8d
	ZkETFfYhjMBcRw5+8y3KSzsVqvalaonh0Cs1UCEfEC6x2/8QI9MEzTAuDWOy4GC85QekKWJkxaf
	0txIQ3UTdZDxdA1lZV+7JdX0vcwshnvk=
X-Gm-Gg: AY/fxX5eWh4KrLUqqK6ERymBagkwD68TIZFgPEd50FeP4ng/8pSoPwTQ1lRYbC69W3/
	+95C7etVlKOw9d00J6Y62gHkI1XitD5Hj1v1E/3jaF49eMJb7DoeuISUdudWydYDynRfghqgqG7
	zIU9+FbwrJKBR8nCSvNCWI7hNAGAHz+SfLN0IUesju9UasQmiInlLl2Ypok0y0AfkhbpdQNYXWg
	s+jUEJtXAy7eFoymQwyL0MLtpbpmWyY41fJRnT+XBwOrChftL8XYslJTMQL4zrrn/doy651
X-Google-Smtp-Source: AGHT+IHqgr7jlDCQgsez8DnA9gOiflIl3Y0LMQ32Pm5ymOJkvX/BBOkn43OWK6VsRVbXsqbrmwwyxgH3uCLfvEaBQjo=
X-Received: by 2002:a05:6a20:918d:b0:366:14b0:4b07 with SMTP id
 adf61e73a8af0-376aa6fa3e9mr2147150637.67.1766133552891; Fri, 19 Dec 2025
 00:39:12 -0800 (PST)
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
References: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com> <c56ef6e76858c7df19ec43a3a18ccf79ff3cc489.camel@codeconstruct.com.au>
In-Reply-To: <c56ef6e76858c7df19ec43a3a18ccf79ff3cc489.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:39:02 +0800
X-Gm-Features: AQt7F2rY9aYq6gs0_U_Uis5_kQpmhb9hiFjrZkiRiPmJac1NTUb6QoRPAfrV0sM
Message-ID: <CABh9gBcntYi6WeL6bOAAboUdic8afmn4X3-LW=zaHDditTr9OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Revise Meta Yosemite5 devicetree
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Sorry for the late reply. I=E2=80=99ve addressed the points raised in your =
review
and sent a follow up v3 patch series. Thanks.

BR,
Kevin

On Mon, Nov 24, 2025 at 12:53=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Thu, 2025-11-20 at 13:25 +0800, Kevin Tung wrote:
> > Summary:
> > Revise linux device tree entry related to Meta (Facebook) Yosemite5.
> >
> > Changes in v2:
> > - Add ipmb node for OCP debug card
> > - Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fc=
d6b44b4497@gmail.com
> >
> > Changes in v1:
> > - Increase i2c4/i2c12 bus speed to 400 kHz
> > - Update sensor configuration
> > - Rename sgpio P0_I3C_APML_ALERT_L
>
> Sorry, I replied with comments on v1 before I saw v2.
>
> Can you please resolve the discussions on v1 and send a follow-up
> series if necessary?
>
> Andrew

