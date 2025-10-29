Return-Path: <linux-aspeed+bounces-2683-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F5CCCF9EE
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 09:52:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxMwr34h9z3bfF;
	Wed, 29 Oct 2025 20:52:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761731548;
	cv=none; b=oLa1NghX8zgfYoMwePViDUty+zK5CxujDcKShpoQC2o34JfyeRuM2e3eSHbXew409ZtY3NAgTKywV4Ir7m2v1moQOvGiFGITL34hidXjB3nivkmBvzk/vbrGYEfxC1sZbBcpO13xko4rt8WvOqsA28lGqgjdD/VG6ibsTn1IqT98T/whvonAfotpVGkLWZtbmpOfiMTY87Vtn6ZHq4dtmCj08ZwTGhBEsAB66JtsNnXMrWFKLC+fx/lULumt0glq2s4SD9W0MEtPPnPVfATy38Nsna39AtXLk4a6RIbXBSNoaZzJZioWvTeewKOGIidRdJPfn2H3+Gdew84ckMmHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761731548; c=relaxed/relaxed;
	bh=dn3HJmw1LqF1sl88KtOEIxVUxtlj7baFmpOOANtcNAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJN5e0t1bXzzq1wbwHcNyt5QhARlp1IvWUQOn9YFKZUTKYqdAYKIEYOtArqiqBKInOKyvQrkIn/lfNwf0zZJhO40Bow+yIE76pWhAh2LX+5tKaAqN5OgwBHH3F/8Ei6vE8TFhO6co3H1fi8ZMemODX0b+R7yTYBFklVzUHYVf7bkCcSCtsFnxTleV2/gkz78fg36R3FuFueKSB5nRHOBQOa31uUqT/3YcbzPXuvVa67qQ2vxJO8aRO5QPslPWT/6qjHn3RlsVrUapD5s/wqC8ozDKXVwBTTt0dgZMfdefCqWMvOmYLcjG/GREqsxnHJx8D7sNQkrA0aHz5SPy63H7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxMwp6Lxzz30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 20:52:26 +1100 (AEDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-55716c1ffeeso1965910e0c.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731542; x=1762336342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn3HJmw1LqF1sl88KtOEIxVUxtlj7baFmpOOANtcNAA=;
        b=Ky/WFTEmCD8cbQvHNR6hQmN3I0LO5iyaiNSfmklLqfjeAZTZeQHZ09BnKMZpNrC6Z/
         nkONOIjHmIlQW2I2OP0ihVLmo7uoAuJYZ4qoJtvuJxi7nYgTn4/kgio8tNX8YImT8knv
         6Ka/aQMf8tKLZgcYaG/HIbOPNSMxvC+K9cidRy5OKfC5LS8/BovsZg+csYB7yUtCYXNt
         JKVeL3MEuXO+f5XcVUaJ6XZ9uS5xjg8YiTMRq/sZ8+3PMNHs5cWfuCTLZ/QWMC5aRGAM
         G2m03gd/S3jQuVmtFTWrUU9be38Lz21VPAf+/Gn6wWOIpHldZNk06X7h5PNE8l6kUquI
         XO9A==
X-Forwarded-Encrypted: i=1; AJvYcCUmZgjD3qBadJolbMP/qFKCOMncApuqO30ZJpIQX9SlcesKkOiQadFNcRKwC7etZJiBLMowpdoz47v3peQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwVMfHeXYsy3Fedq4cRzmx0/Esb/7fWY7itEtuo7thH0uzitTmK
	XPL3y1ANTUVW80lU3m56jGsKC4a9Q8MKRjFdOH/RUOZjHN5P/a0lDwu9swfHPk0k
X-Gm-Gg: ASbGncvB9nFe44IaOJgN7V3gMFlEQAziMZ8FZxmkF9RLYUhwy4S5ta5fTVe3DziSX1y
	0MLRKiM+NVpfzrTrXweMp4xk/08ZErTyg7PZNlHfrApTfSzH+pic+nCAWTUHkqLKv9oNmZlf1Gi
	cz/bZTubdnxcskJjzmKRj39egBpTcH0TRVghumJGvGPgou9TDnsdD1OotvYsEFGNsfHmPglt+90
	9ajkBi2uzibB7ylh35B8v6OPSODtgOjcVXaFwP1NuNIc4EvHMi22oN3tHWjFaE4j+r7mSU5pLg8
	2WTe8FQ/UTZYrytNfN/No74gInHVFcvIjLZeb+vzX/1sYRyhUVFrf0Ge/TX1LotTsBEC7+FDRVf
	nAr91QHNSpuMk15Mcd2I8gEaCdRS64+YXdGYYBMZ2YjmBeqZ8OXFmR84NMB6VB8HImv03wOuc6i
	H+RppjOdFlKBoUk3g2hvIUydmrYD7Ww9cGUyoB2iFEcCc3DWt9
X-Google-Smtp-Source: AGHT+IGiwJ2MjEbzVyX8xebCaJ83GG+X/oJ8YXrC0BV9qx1PQOpLHRdps3u1YZ0IUKqHFOqPkY1c3A==
X-Received: by 2002:a05:6122:16a0:b0:557:c573:d226 with SMTP id 71dfb90a1353d-558141572eemr533677e0c.5.1761731542360;
        Wed, 29 Oct 2025 02:52:22 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb5f493sm5285324e0c.17.2025.10.29.02.52.22
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:52:22 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-932bbd6ba76so2374468241.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 02:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuOaYptNWNOdTRQQqOVjBXxTSRiOwR6oHJCJi15FhidzLqcykcay0Z/TQa3AUVJCQep1gRYpO71R7StPw=@lists.ozlabs.org
X-Received: by 2002:a05:6102:942:b0:5d7:de89:ddd6 with SMTP id
 ada2fe7eead31-5db9057bad9mr557441137.1.1761731536861; Wed, 29 Oct 2025
 02:52:16 -0700 (PDT)
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
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com> <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com> <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch> <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch> <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch> <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
 <TY2PPF5CB9A1BE6D0FC241696E44EB1F463F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PPF5CB9A1BE6D0FC241696E44EB1F463F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:52:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKsyt_bXaJ=smtCaGst_5O2trQakxmaKp2K1Jzc=Y9uA@mail.gmail.com>
X-Gm-Features: AWmQ_bnPsVrgzrwpS4yuU54P6rGfuwJuhD3QhZm5C-G0nVGXJf4URRbbI7AGLcc
Message-ID: <CAMuHMdWKsyt_bXaJ=smtCaGst_5O2trQakxmaKp2K1Jzc=Y9uA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Taniya Das <quic_tdas@quicinc.com>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Wed, 29 Oct 2025 at 03:38, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC=
 device
> > On Mon, 27 Oct 2025 at 13:01, Andrew Lunn <andrew@lunn.ch> wrote:
> > > On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > > > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial
> > > > > AST2700 SoC device tree
> > > > >
> > > > > > SoC0, referred to as the CPU die, contains a dual-core
> > > > > > Cortex-A35 cluster and two Cortex-M4 cores, along with its own
> > > > > > clock/reset domains and high-speed peripheral set.
> > > > >
> > > > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
> > > > > > own clock/reset domains and low-speed peripheral set, and is
> > > > > > responsible for system boot and control functions.
> > > > >
> > > > > So is the same .dtsi file shared by both systems?
> > > >
> > > > This .dtsi represents the Cortex-A35 view only and is not shared
> > > > with the Cortex-M4 or the Boot MCU side, since they are separate
> > > > 32-bit and 64-bit systems running independent firmware.
> > >
> > > DT describes the hardware. The .dtsi file could be shared, you just
> > > need different status =3D <>; lines in the dtb blob.
> > >
> > > > > How do you partition devices
> > > > > so each CPU cluster knows it has exclusive access to which periph=
erals?
> > > >
> > > > Before the system is fully brought up, Boot MCU configure hardware
> > > > controllers handle the resource partitioning to ensure exclusive ac=
cess.
> > >
> > > Are you saying it modifies the .dtb blob and changes some status =3D
> > > "okay"; to "disabled";?
> >
> > "reserved" is the appropriate status value for that.
>
> Thanks for the clarification.
>
> Since the SoC-level .dtsi is shared by all users (potentially other platf=
orms),
> I don=E2=80=99t actually know in advance which peripherals will be assign=
ed to
> which CPU. For this reason, marking nodes as `status =3D "reserved"` in t=
he
> .dtsi might be misleading.

Sure, not in the SoC-specific .dtsi.

> I think it=E2=80=99s more appropriate to keep all peripherals as
> `status =3D "disabled"` in the common .dtsi, and let each board-level .dt=
s or
> firmware-specific DT decide whether a device should be `okay` or `reserve=
d`
> depending on the actual resource assignment.

Correct.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

