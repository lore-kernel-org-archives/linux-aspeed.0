Return-Path: <linux-aspeed+bounces-4707-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D59FC5B572
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:40:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk0b6ZDWz2yRc;
	Fri, 14 Aug 2026 10:40:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786620677;
	cv=pass; b=Qjj8rZpuZ2AwpGPZn7qv5lLU+eR3hfHVTCGcwwXQX+Sqy6zFttQVF8G7gF/MhWWkZDgHVghZtv7Pb40wBqKq8BmuLyZjEjE2hcrpsrvzf1f2zf1OgOaZhP5rC56SILqxP6bLBLpKjRnlLLIxONO0QeScfJhHeCOGslT6OAEiw0wAEEpkJ+zEysPR7kg6eqA7C+h7Y27gEB1DSMHduRSlTfe3w9mSNOU5I3iKV10UOOg8Rp0i7Dx5RTx+WfNmdknm4wyY0TPDtZ/lVbV8wXHRzgSATal3OqIaue/5Xbq7GAT7IFrHV+loY6ZEafb2YGLHJFGtgmlopAqaiAZC+c/p4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786620677; c=relaxed/relaxed;
	bh=x7NgFlCM8A4+p38U/2RjzmQm4qQ3QmH2qsBm0aXcsIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tn7//VD6BTejHkeeQUQIpmQV+Xq68KxeN2Mr4ZT/tTUgf0WEikHBwc80114JUfzD/3shmCgSXYoPyRCPhGtepPVPQSGtqj/thexmzaMPOW39p6VEFykvQ5hfJbJA+UyujxBBK3v8HptjNrPe42XRrL52mAYVMzTcbx6lSt1Ayf3JDgsHprm+Aac1sEwkHStGc0Jlhqg5Tek9HRy5Y/4EYCmWvby+wkcf7RjEv/yDELe+2xMNY13L10AloYvG8+q78nB5vJgTZOfvDn3I6hhLZvQQY0v6Aw7HClT5Kk9U4/43d8tt0A2aaK81lrFYrMC4NnmEUeRPdkSR1eOKz+xViQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/ljPHof; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/ljPHof;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLNTt0BbPz2y32
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 21:31:12 +1000 (AEST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-745659c70ccso511036137.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 04:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786620669; cv=none;
        d=google.com; s=arc-20260327;
        b=OB0a0ZlEtgdyBCk/qKxipC2xajkYTDJbZAg3wrgW0YgeYtDdxXplI9yFs01L2j1Yp7
         spVc8stIjqUSJMx6+Vad5PISnIAk/yd1gWan7vNnuLD7bZyZ+bvOQTFR4pIvoXmzpl5z
         zwr+x+UJywCCTMpVqvz6QhvMr/nOjb2mx14SeQUWV9BlO3zpt8QZdU2n2lQ8YKh/kvP/
         QNNSuYArbEmnQR6ReSSMukOg/O/fY7oEXTORhmRkjBGXFSJ082sBinruwE9VMG/EaDsF
         9uxzWdzbs1MIrMEidkIRQe+QV+9JklV0H81Ww8pKp5+iNFcYfifPOQET4Rn4/qwJ71Dw
         pNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x7NgFlCM8A4+p38U/2RjzmQm4qQ3QmH2qsBm0aXcsIs=;
        fh=cxvSERiE7X9jpWmmnXJTY6ToQ2d+VsXbe7WMRhI0XN8=;
        b=bk6WXBhAuqE+fqpnHzVoij9t0pMW3HHgbRqdz3F4hEpghEuZiKREmzVgNk/BdiBOB1
         ACipmV56uB6jJaDEn0ByllL/SEL4qT0KpdlzgrcQu2ZbAAAbJr0fjSznbBlESRXfLgdg
         YTU3mvGFwJCCdoH9qcZERlaapIlUkpM89Sq5tzqvyA6nWW7k8MGpuoOqRfhCipEMtZwV
         YWjrBnw2mVj42mQKBXOM2frAUzmYndb4O0HcvbOKLLC4H77xjPt8KuLL2lM0p+nd2/gD
         oblvt+TIVxWG1rwmYABlP098Azj+Y1K8ATvWdaZV8dZpN2J1Xxe03syCGonNDLJywt82
         lT2Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786620669; x=1787225469; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7NgFlCM8A4+p38U/2RjzmQm4qQ3QmH2qsBm0aXcsIs=;
        b=e/ljPHofeK0wlT9FQs+C7+L4BGQGq6UQS7Bv5fQVPM+pvx1B6EstNdlUGy1sKRfe99
         hwkgWiwGD+mhY2N/e9+xre2k/UFelCnuhHRZtXAo4cgvzQIQLlQMib2DDmlNUbVLJYMO
         UFt3iyIwDPDHH/hnbcVUDTuBntqytjWSZn+pmfmFTgjsovPvBCusQOL/CIFKiLT9Ekwe
         dhsFdETepLAqM7+YpcVn5g804DKh+6plXX7S4LCJp4xUwbouvOlJg623SPbfDvGzO9l/
         8V8HZH2WgvPyLekkrWYV1N9dsAPNVfEhMvQI7qfcXcfO2trstJhe1N1IknXgH93izD6k
         L8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620669; x=1787225469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7NgFlCM8A4+p38U/2RjzmQm4qQ3QmH2qsBm0aXcsIs=;
        b=qKg7zs9lYTHX03t1zNYq3zY4VYE3x8Xm432lCjbmnbrWEE5Fz3HBuwbshjxgD9wErL
         dfyhStLRgOWd92BMWMLdAIs2FD9fipp9vKaSNfMQv07qm41AlWuBE2VUCPBzuXWPeOyq
         k4EDhxQZ30I+EQVTBX1RuI/9wPAOWDHY4I6g/cj7lZvIP6PUQA1rtBcdVJRkMkVzP5up
         30d6zAcyszuro50R0tEvvmgxzCWxKCs8IaiBfp29rpVIjy27FfR7JyS/YoJP4Iu+9RfU
         9wMnFzI+6LK8AhCXXyJA+oA2OXx++dFuYoIoALQcgPX5BqYsvuCGCze4aAvlI+/8wwVD
         5ODQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYz0hs0n5c+Y5aQz1uby4dUg46yAzKM3g1Tn5hVDiDBtPaIPS5X5or+4+uMIK97vl2GRS8VauzIrP2vJA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzorQiF/Ez3OIkX94IlLJNWbmHGfX7+AkRvLhZCpDeitgAtstC8
	aegvE4Y5gUSsHWdGEXIpD80bytYTxs5s7YHTq9z9SG457JQFL3tsFqGnt+h4XwmCKhHl1oaZh8c
	fPbDm13h9szzPaSl55u/Ymu8mkWtR9Lc=
X-Gm-Gg: AR+sD13kUctTsGmAYT4E+jdrw3XzfHk7AYzQ90rUR4gx3tFbz+g+/7CgyxR0reAGDWI
	rdADUVyOyghHztF/qFg/J/VMEdUpvC5hFdetLTAoj0npwT7sGJ/MA26J63xTEeWFqNxqdmDLozS
	Vy5N8k2kI7Qws2x67vSsEnkXwiXgZc8OIvc+oH2QuCvu7B2lJLxfcwzsaouw43oyxe+95eFNkh2
	wVEzmZbuZp0sGwMhpA9Qvb3Oyu0nyVjDq07ZuoI6l2o3LGQrRw8w0WWgMBCfkDRaMHiWu5NOKif
	mRPRLQ6HrpkatQta4H8dT0abTjtsW0e7wARcfnNFkB7Pef0=
X-Received: by 2002:a05:6102:1496:b0:740:2d81:c2a2 with SMTP id
 ada2fe7eead31-76db85675b9mr1244984137.10.1786620668492; Thu, 13 Aug 2026
 04:31:08 -0700 (PDT)
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
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
 <20260805-anacapa-devlop-phase-devicetree-v4-2-5d67e0efa6c5@gmail.com> <178618669276.50041.10651670181152112668.b4-review@b4>
In-Reply-To: <178618669276.50041.10651670181152112668.b4-review@b4>
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 13 Aug 2026 19:30:55 +0800
X-Gm-Features: AUfX_mz09ZEweX8Yu0r_Ge3r5esfHNdYwRpaRxgq6zus3X48GAxphP73Lw7ihoM
Message-ID: <CAPBH0A-cjqH_n4uvsVf5qrBAmR5o3fyHeOgxxF5nsmQqYEoCvg@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] ARM: dts: aspeed: anacapa: Add EVT1 devicetree
 and point wrapper to it
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Colin Huang <colin.huang2@amd.com>
Content-Type: multipart/alternative; boundary="0000000000004b405f0658ec0a1d"

--0000000000004b405f0658ec0a1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tan Siewert <tan.siewert@9elements.com> =E6=96=BC 2026=E5=B9=B48=E6=9C=888=
=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=887:58 =E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi Colin,
>
> > This change introduces a development-phase devicetree for the
> > Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa
> > wrapper DTS to reference it.
>
>
> >
> > A dedicated EVT1 DTS is added for revision-specific hardware while
> > keeping a single, Anacapa entrypoint used by the build and deployment
> > flow. The top-level aspeed-bmc-facebook-anacapa.dts
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
>
>
>
>
> >
> > diff --git
> a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> > new file mode 100644
> > index 000000000000..a095be48a3fe
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
>
> `scripts/dtc/dt-check-style --mode strict` reports multiple errors:
>
>     aspeed-bmc-facebook-anacapa-evt1.dts:10: [property-order] property
> 'compatible' out of canonical order (should sort before 'model')
>     aspeed-bmc-facebook-anacapa-evt1.dts:18: [property-order] property
> 'i2c16' out of canonical order (should sort before 'serial4')
>     aspeed-bmc-facebook-anacapa-evt1.dts:71: [continuation-alignment]
> continuation should align to column 31 (under "<" or \")
>     aspeed-bmc-facebook-anacapa-evt1.dts:72: [continuation-alignment]
> continuation should align to column 31 (under "<" or \")
>     aspeed-bmc-facebook-anacapa-evt1.dts:80: [property-order] property
> 'gpios' out of canonical order (should sort before 'label')
>     aspeed-bmc-facebook-anacapa-evt1.dts:86: [property-order] property
> 'default-state' out of canonical order (should sort before 'label')
>     aspeed-bmc-facebook-anacapa-evt1.dts:93: [property-order] property
> 'reg' out of canonical order (should sort before 'device_type')
>     aspeed-bmc-facebook-anacapa-evt1.dts:99: [property-order] property
> 'ranges' out of canonical order (should sort before '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:103: [property-order] property
> 'alignment' out of canonical order (should sort before 'size')
>     aspeed-bmc-facebook-anacapa-evt1.dts:104: [property-order] property
> 'compatible' out of canonical order (should sort before 'alignment')
>     aspeed-bmc-facebook-anacapa-evt1.dts:108: [child-name-order] child
> node 'framebuffer' out of name order
>     aspeed-bmc-facebook-anacapa-evt1.dts:110: [property-order] property
> 'alignment' out of canonical order (should sort before 'size')
>     aspeed-bmc-facebook-anacapa-evt1.dts:111: [property-order] property
> 'compatible' out of canonical order (should sort before 'alignment')
>     aspeed-bmc-facebook-anacapa-evt1.dts:116: [child-name-order] child
> node 'regulator-p3v3-bmc-aux' out of name order
>     aspeed-bmc-facebook-anacapa-evt1.dts:116: [unused-labels] label
> 'p3v3_bmc_aux' defined but never &-referenced
>     aspeed-bmc-facebook-anacapa-evt1.dts:119: [property-order] property
> 'regulator-min-microvolt' out of canonical order (should sort before
> 'regulator-name')
>     aspeed-bmc-facebook-anacapa-evt1.dts:120: [property-order] property
> 'regulator-max-microvolt' out of canonical order (should sort before
> 'regulator-min-microvolt')
>     aspeed-bmc-facebook-anacapa-evt1.dts:121: [property-order] property
> 'regulator-always-on' out of canonical order (should sort before
> 'regulator-max-microvolt')
>     aspeed-bmc-facebook-anacapa-evt1.dts:124: [unused-labels] label
> 'spi_gpio' defined but never &-referenced
>     aspeed-bmc-facebook-anacapa-evt1.dts:129: [property-order] property
> 'sck-gpios' out of canonical order (should sort before '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:130: [property-order] property
> 'mosi-gpios' out of canonical order (should sort before 'sck-gpios')
>     aspeed-bmc-facebook-anacapa-evt1.dts:131: [property-order] property
> 'miso-gpios' out of canonical order (should sort before 'mosi-gpios')
>     aspeed-bmc-facebook-anacapa-evt1.dts:132: [property-order] property
> 'cs-gpios' out of canonical order (should sort before 'miso-gpios')
>     aspeed-bmc-facebook-anacapa-evt1.dts:134: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:139: [property-order] property
> 'reg' out of canonical order (should sort before 'spi-max-frequency')
>     aspeed-bmc-facebook-anacapa-evt1.dts:146: [property-order] property
> 'pinctrl-names' out of canonical order (should sort before
> 'aspeed,int-vref-microvolt')
>     aspeed-bmc-facebook-anacapa-evt1.dts:147: [property-order] property
> 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
>     aspeed-bmc-facebook-anacapa-evt1.dts:148: [continuation-alignment]
> continuation should align to column 21 (under "<" or \")
>     aspeed-bmc-facebook-anacapa-evt1.dts:149: [continuation-alignment]
> continuation should align to column 21 (under "<" or \")
>     aspeed-bmc-facebook-anacapa-evt1.dts:150: [continuation-alignment]
> continuation should align to column 21 (under "<" or \")
>     aspeed-bmc-facebook-anacapa-evt1.dts:151: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:156: [property-order] property
> 'pinctrl-names' out of canonical order (should sort before
> 'aspeed,int-vref-microvolt')
>     aspeed-bmc-facebook-anacapa-evt1.dts:157: [property-order] property
> 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
>     aspeed-bmc-facebook-anacapa-evt1.dts:158: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:170: [property-order] property
> 'm25p,fast-read' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:171: [property-order] property
> 'label' out of canonical order (should sort before 'm25p,fast-read')
>     aspeed-bmc-facebook-anacapa-evt1.dts:178: [property-order] property
> 'm25p,fast-read' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:179: [property-order] property
> 'label' out of canonical order (should sort before 'm25p,fast-read')
>     aspeed-bmc-facebook-anacapa-evt1.dts:186: [property-order] property
> 'memory-region' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:314: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:321: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:326: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:331: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:354: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:361: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:366: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:371: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:388: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:395: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:400: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:405: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:410: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:415: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:420: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:425: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] consecutive
> blank lines
>     aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] blank line at
> end of node body
>     aspeed-bmc-facebook-anacapa-evt1.dts:465: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:482: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:487: [property-order] property
> 'gpio-line-names' out of canonical order (should sort before 'interrupts'=
)
>     aspeed-bmc-facebook-anacapa-evt1.dts:504: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:509: [property-order] property
> 'gpio-line-names' out of canonical order (should sort before 'interrupts'=
)
>     aspeed-bmc-facebook-anacapa-evt1.dts:527: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:536: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:541: [property-order] property
> 'gpio-line-names' out of canonical order (should sort before 'interrupts'=
)
>     aspeed-bmc-facebook-anacapa-evt1.dts:556: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:561: [property-order] property
> 'gpio-line-names' out of canonical order (should sort before 'interrupts'=
)
>     aspeed-bmc-facebook-anacapa-evt1.dts:578: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:583: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:617: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:624: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:629: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:634: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:639: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:644: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:653: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:672: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:677: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:694: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:701: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:706: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:711: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:716: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:721: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:730: [property-order] property
> '#gpio-cells' out of canonical order (should sort before 'gpio-controller=
')
>     aspeed-bmc-facebook-anacapa-evt1.dts:749: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:754: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:776: [property-order] property
> 'i2c-mux-idle-disconnect' out of canonical order (should sort before
> '#size-cells')
>     aspeed-bmc-facebook-anacapa-evt1.dts:783: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:788: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:793: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:804: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:815: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:820: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:825: [required-blank-lines] chil=
d
> node must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:837: [property-order] property
> 'enable-gpios' out of canonical order (should sort before 'interrupts')
>     aspeed-bmc-facebook-anacapa-evt1.dts:854: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:859: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:868: [property-order] property
> 'pinctrl-names' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:869: [property-order] property
> 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
>     aspeed-bmc-facebook-anacapa-evt1.dts:875: [property-order] property
> 'bus-frequency' out of canonical order (should sort before 'ngpios')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1020: [property-order] property
> 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1021: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:1022: [property-order] property
> 'reg' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1029: [property-order] property
> 'spi-rx-bus-width' out of canonical order (should sort before
> 'spi-tx-bus-width')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1030: [required-blank-lines]
> "status" must be preceded by a blank line
>     aspeed-bmc-facebook-anacapa-evt1.dts:1062: [property-order] property
> 'pinctrl-names' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1067: [property-order] property
> 'memory-region' out of canonical order (should sort before 'status')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1072: [property-order] property
> 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1074: [property-order] property
> 'aspeed,external-signal' out of canonical order (should sort before
> 'aspeed,reset-type')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1075: [property-order] property
> 'aspeed,ext-push-pull' out of canonical order (should sort before
> 'aspeed,external-signal')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1076: [property-order] property
> 'aspeed,ext-active-high' out of canonical order (should sort before
> 'aspeed,ext-push-pull')
>     aspeed-bmc-facebook-anacapa-evt1.dts:1078: [required-blank-lines]
> "status" must be preceded by a blank line
>
> I will run this script and fix issues.



> > @@ -0,0 +1,1079 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/dts-v1/;
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +#include <dt-bindings/i2c/i2c.h>
> > +
> > +/ {
> > +     model =3D "Facebook Anacapa BMC";
> > +     compatible =3D "facebook,anacapa-bmc-evt1", "aspeed,ast2600";
> > +
> > +     aliases {
> > +             serial0 =3D &uart1;
> > +             serial1 =3D &uart2;
> > +             serial2 =3D &uart3;
> > +             serial3 =3D &uart4;
> > +             serial4 =3D &uart5;
> > +             i2c16 =3D &i2c0mux0ch0;
> > +             i2c17 =3D &i2c0mux0ch1;
> > +             i2c18 =3D &i2c0mux0ch2;
> > +             i2c19 =3D &i2c0mux0ch3;
> > +             i2c20 =3D &i2c1mux0ch0;
> > +             i2c21 =3D &i2c1mux0ch1;
> > +             i2c22 =3D &i2c1mux0ch2;
> > +             i2c23 =3D &i2c1mux0ch3;
> > +             i2c24 =3D &i2c4mux0ch0;
> > +             i2c25 =3D &i2c4mux0ch1;
> > +             i2c26 =3D &i2c4mux0ch2;
> > +             i2c27 =3D &i2c4mux0ch3;
> > +             i2c28 =3D &i2c4mux0ch4;
> > +             i2c29 =3D &i2c4mux0ch5;
> > +             i2c30 =3D &i2c4mux0ch6;
> > +             i2c31 =3D &i2c4mux0ch7;
> > +             i2c32 =3D &i2c8mux0ch0;
> > +             i2c33 =3D &i2c8mux0ch1;
> > +             i2c34 =3D &i2c8mux0ch2;
> > +             i2c35 =3D &i2c8mux0ch3;
> > +             i2c36 =3D &i2c10mux0ch0;
> > +             i2c37 =3D &i2c10mux0ch1;
> > +             i2c38 =3D &i2c10mux0ch2;
> > +             i2c39 =3D &i2c10mux0ch3;
> > +             i2c40 =3D &i2c10mux0ch4;
> > +             i2c41 =3D &i2c10mux0ch5;
> > +             i2c42 =3D &i2c10mux0ch6;
> > +             i2c43 =3D &i2c10mux0ch7;
> > +             i2c44 =3D &i2c11mux0ch0;
> > +             i2c45 =3D &i2c11mux0ch1;
> > +             i2c46 =3D &i2c11mux0ch2;
> > +             i2c47 =3D &i2c11mux0ch3;
> > +             i2c48 =3D &i2c11mux0ch4;
> > +             i2c49 =3D &i2c11mux0ch5;
> > +             i2c50 =3D &i2c11mux0ch6;
> > +             i2c51 =3D &i2c11mux0ch7;
> > +             i2c52 =3D &i2c13mux0ch0;
> > +             i2c53 =3D &i2c13mux0ch1;
> > +             i2c54 =3D &i2c13mux0ch2;
> > +             i2c55 =3D &i2c13mux0ch3;
> > +             i2c56 =3D &i2c13mux0ch4;
> > +             i2c57 =3D &i2c13mux0ch5;
> > +             i2c58 =3D &i2c13mux0ch6;
> > +             i2c59 =3D &i2c13mux0ch7;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial4:57600n8";
> > +     };
> > +
> > +     iio-hwmon {
> > +             compatible =3D "iio-hwmon";
> > +             io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3=
>,
> > +                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0
> 7>,
> > +                               <&adc1 2>;
> > +     };
> > +
> > +     leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-0 {
> > +                     label =3D "bmc_heartbeat_amber";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_L=
OW>;
> > +                     linux,default-trigger =3D "heartbeat";
> > +             };
> > +
> > +             led-1 {
> > +                     label =3D "fp_id_amber";
> > +                     default-state =3D "off";
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(B, 5)
> GPIO_ACTIVE_HIGH>;
> > +             };
> > +     };
> > +
> > +     memory@80000000 {
> > +             device_type =3D "memory";
> > +             reg =3D <0x80000000 0x80000000>;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +
> > +             video_engine_memory: video {
> > +                     size =3D <0x02c00000>;
> > +                     alignment =3D <0x00100000>;
> > +                     compatible =3D "shared-dma-pool";
> > +                     reusable;
> > +             };
> > +
> > +             gfx_memory: framebuffer {
> > +                     size =3D <0x01000000>;
> > +                     alignment =3D <0x01000000>;
> > +                     compatible =3D "shared-dma-pool";
> > +                     reusable;
> > +             };
> > +     };
> > +
> > +     p3v3_bmc_aux: regulator-p3v3-bmc-aux {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "p3v3_bmc_aux";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     spi_gpio: spi {
> > +             compatible =3D "spi-gpio";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             sck-gpios =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>=
;
> > +             mosi-gpios =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH=
>;
> > +             miso-gpios =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH=
>;
> > +             cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> > +             num-chipselects =3D <1>;
> > +             status =3D "okay";
> > +
> > +             tpm@0 {
> > +                     compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
> > +                     spi-max-frequency =3D <33000000>;
> > +                     reg =3D <0>;
> > +             };
> > +     };
> > +};
>
> *snip*
>
> > +// AMC
> > +&i2c5 {
> > +     status =3D "okay";
> > +};
> > +
> > +// MB
> > +&i2c6 {
> > +     status =3D "okay";
> > +
> > +     // HPM FRU
> > +     eeprom@50 {
> > +             compatible =3D "atmel,24c256";
> > +             reg =3D <0x50>;
> > +     };
> > +};
> > +
> > +// SCM
> > +&i2c7 {
> > +     status =3D "okay";
> > +
> > +
>
> Unnecessary newlines.
>
> > +};
> > +
> > +// MB - PDB
> > +&i2c8 {
> > +     status =3D "okay";
> > +
> > +     i2c-mux@72 {
> > +             compatible =3D "nxp,pca9546";
> > +             reg =3D <0x72>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             i2c-mux-idle-disconnect;
> > +
> > +             i2c8mux0ch0: i2c@0 {
> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     adc@1f {
> > +                             compatible =3D "ti,adc128d818";
> > +                             reg =3D <0x1f>;
> > +                             ti,mode =3D /bits/ 8 <1>;
> > +                     };
> > +
> > +                     gpio@22 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             interrupt-parent =3D <&sgpiom0>;
> > +                             interrupts =3D <174 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                             gpio-line-names =3D
> > +                                     "RPDB_FAN_FULL_SPEED_R_N",
> "RPDB_I2C_TEMP75_U8_ALERT_R_N",
> > +                                     "RPDB_I2C_TMP432_U29_ALERT_R_N",
> "RPDB_GLOBAL_WP",
> > +                                     "RPDB_FAN_CT_FAN_FAIL_R_N", "",
> > +                                     "", "",
> > +                                     "RPDB_ALERT_P50V_HSC2_R_N",
> "RPDB_ALERT_P50V_HSC3_R_N",
> > +                                     "RPDB_ALERT_P50V_HSC4_R_N",
> "RPDB_ALERT_P50V_STBY_R_N",
> > +                                     "RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
> > +                                     "RPDB_I2C_P12V_STBY_VRM_ALERT_R_N=
",
> > +                                     "RPDB_PGD_P3V3_STBY_PWRGD_R",
> > +                                     "RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
> > +                     };
> > +
> > +                     gpio@24 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x24>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             interrupt-parent =3D <&sgpiom0>;
> > +                             interrupts =3D <174 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                             gpio-line-names =3D
> > +                                     "RPDB_EAM2_PRSNT_MOS_N_R",
> "RPDB_EAM3_PRSNT_MOS_N_R",
> > +                                     "RPDB_PWRGD_P50V_HSC4_SYS_R",
> > +                                     "RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
> > +                                     "RPDB_P50V_FAN1_R2_PG",
> "RPDB_P50V_FAN2_R2_PG",
> > +                                     "RPDB_P50V_FAN3_R2_PG",
> "RPDB_P50V_FAN4_R2_PG",
> > +                                     "", "RPDB_FAN1_PRSNT_N_R",
> > +                                     "", "RPDB_FAN2_PRSNT_N_R",
> > +                                     "RPDB_FAN3_PRSNT_N_R",
> "RPDB_FAN4_PRSNT_N_R",
> > +                                     "", "";
> > +                     };
> > +
> > +                     // R-PDB FRU
> > +                     eeprom@50 {
> > +                             compatible =3D "atmel,24c128";
> > +                             reg =3D <0x50>;
> > +                     };
> > +             };
> > +             i2c8mux0ch1: i2c@1 {
> > +                     reg =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     gpio@22 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             interrupt-parent =3D <&sgpiom0>;
> > +                             interrupts =3D <174 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                             gpio-line-names =3D
> > +
>  "LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
> > +
>  "LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
> > +                                     "LPDB_FAN_CT_FAN_FAIL_R_N","",
> > +                                     "","",
> > +
>  "LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
> > +
>  "LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
> > +
>  "LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
> > +                                     "LPDB_PWRGD_P50V_HSC5_SYS_R","";
> > +                     };
> > +
> > +                     gpio@24 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x24>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             interrupt-parent =3D <&sgpiom0>;
> > +                             interrupts =3D <174 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                             gpio-line-names =3D
> > +
>  "LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
> > +
>  "LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
> > +
>  "LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
> > +
>  "LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
> > +
>  "LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
> > +                                     "","",
> > +                                     "","",
> > +                                     "","";
> > +                     };
> > +
> > +                     // L-PDB FRU
> > +                     eeprom@50 {
> > +                             compatible =3D "atmel,24c128";
> > +                             reg =3D <0x50>;
> > +                     };
> > +             };
> > +             i2c8mux0ch2: i2c@2 {
> > +                     reg =3D <2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c8mux0ch3: i2c@3 {
> > +                     reg =3D <3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> > +// SCM
> > +&i2c9 {
> > +     status =3D "okay";
> > +
> > +     // SCM FRU
> > +     eeprom@50 {
> > +             compatible =3D "atmel,24c128";
> > +             reg =3D <0x50>;
> > +     };
> > +
> > +     // BSM FRU
> > +     eeprom@56 {
> > +             compatible =3D "atmel,24c64";
> > +             reg =3D <0x56>;
> > +     };
> > +};
> > +
> > +// R Bridge Board
> > +&i2c10 {
> > +     status =3D "okay";
> > +
> > +     i2c-mux@71 {
> > +             compatible =3D "nxp,pca9548";
> > +             reg =3D <0x71>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             i2c-mux-idle-disconnect;
> > +
> > +             i2c10mux0ch0: i2c@0 {
> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch1: i2c@1 {
> > +                     reg =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch2: i2c@2 {
> > +                     reg =3D <2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch3: i2c@3 {
> > +                     reg =3D <3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch4: i2c@4 {
> > +                     reg =3D <4>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch5: i2c@5 {
> > +                     reg =3D <5>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     gpio@22 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             gpio-line-names =3D
> > +                                     "","",
> > +                                     "","RBB_CPLD_REFRESH_IN_PRGRS_R_L=
",
> > +
>  "RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
> > +
>  "RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
> > +
>  "RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
> > +
>  "RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
> > +
>  "RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
> > +                                     "","";
> > +                     };
> > +
> > +                     // R Bridge Board FRU
> > +                     eeprom@52 {
> > +                             compatible =3D "atmel,24c256";
> > +                             reg =3D <0x52>;
> > +                     };
> > +             };
> > +             i2c10mux0ch6: i2c@6 {
> > +                     reg =3D <6>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c10mux0ch7: i2c@7 {
> > +                     reg =3D <7>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> > +// L Bridge Board
> > +&i2c11 {
> > +     status =3D "okay";
> > +
> > +     i2c-mux@71 {
> > +             compatible =3D "nxp,pca9548";
> > +             reg =3D <0x71>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             i2c-mux-idle-disconnect;
> > +
> > +             i2c11mux0ch0: i2c@0 {
> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch1: i2c@1 {
> > +                     reg =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch2: i2c@2 {
> > +                     reg =3D <2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch3: i2c@3 {
> > +                     reg =3D <3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch4: i2c@4 {
> > +                     reg =3D <4>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch5: i2c@5 {
> > +                     reg =3D <5>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     gpio@22 {
> > +                             compatible =3D "nxp,pca9555";
> > +                             reg =3D <0x22>;
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +
> > +                             gpio-line-names =3D
> > +                                     "","",
> > +                                     "","LBB_CPLD_REFRESH_IN_PRGRS_R_L=
",
> > +
>  "LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
> > +
>  "LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
> > +
>  "LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
> > +
>  "LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
> > +
>  "LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
> > +                                     "","";
> > +                     };
> > +
> > +                     // L Bridge Board FRU
> > +                     eeprom@52 {
> > +                             compatible =3D "atmel,24c256";
> > +                             reg =3D <0x52>;
> > +                     };
> > +             };
> > +             i2c11mux0ch6: i2c@6 {
> > +                     reg =3D <6>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c11mux0ch7: i2c@7 {
> > +                     reg =3D <7>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +     };
> > +};
> > +
> > +// Debug Card
> > +&i2c12 {
> > +     status =3D "okay";
> > +};
> > +
> > +// MB
> > +&i2c13 {
> > +     status =3D "okay";
> > +
> > +     i2c-mux@70 {
> > +             compatible =3D "nxp,pca9548";
> > +             reg =3D <0x70>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             i2c-mux-idle-disconnect;
> > +
> > +             i2c13mux0ch0: i2c@0 {
> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c13mux0ch1: i2c@1 {
> > +                     reg =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c13mux0ch2: i2c@2 {
> > +                     reg =3D <2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c13mux0ch3: i2c@3 {
> > +                     reg =3D <3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     adc@1f {
> > +                             compatible =3D "ti,adc128d818";
> > +                             reg =3D <0x1f>;
> > +                             ti,mode =3D /bits/ 8 <1>;
> > +                     };
> > +             };
> > +             i2c13mux0ch4: i2c@4 {
> > +                     reg =3D <4>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     // HPM BRD ID FRU
> > +                     eeprom@51 {
> > +                             compatible =3D "atmel,24c256";
> > +                             reg =3D <0x51>;
> > +                     };
> > +             };
> > +             i2c13mux0ch5: i2c@5 {
> > +                     reg =3D <5>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c13mux0ch6: i2c@6 {
> > +                     reg =3D <6>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +             };
> > +             i2c13mux0ch7: i2c@7 {
> > +                     reg =3D <7>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     nfc@28 {
> > +                             compatible =3D "nxp,nxp-nci-i2c";
> > +                             reg =3D <0x28>;
> > +
> > +                             interrupt-parent =3D <&sgpiom0>;
> > +                             interrupts =3D <156 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                             enable-gpios =3D <&sgpiom0 241
> GPIO_ACTIVE_HIGH>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +// SCM
> > +&i2c14 {
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c15 {
> > +     status =3D "okay";
> > +};
> > +
> > +&kcs2 {
> > +     aspeed,lpc-io-reg =3D <0xca8>;
> > +     status =3D "okay";
> > +};
> > +
> > +&kcs3 {
> > +     aspeed,lpc-io-reg =3D <0xca2>;
> > +     status =3D "okay";
> > +};
> > +
> > +&lpc_ctrl {
> > +     status =3D "okay";
> > +};
> > +
> > +&mac2 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_ncsi3_default>;
> > +     use-ncsi;
> > +};
> > +
> > +&sgpiom0 {
> > +     ngpios =3D <128>;
> > +     bus-frequency =3D <2000000>;
> > +     gpio-line-names =3D
> > +     /*in - out - in - out */
> > +     /* A0-A7 line 0-15 */
> > +     "", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
> > +     "", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
> > +     "", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
> > +     "", "", "", "",
> > +
> > +     /* B0-B7 line 16-31 */
> > +     "Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
> > +     "Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
> > +     "Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
> > +     "Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
> > +     "Channel4_leakage_Manifold2", "",
> > +     "Channel5_leakage_EAM1", "",
> > +     "Channel6_leakage_CPU_DIMM", "",
> > +     "Channel7_leakage_EAM2", "",
> > +
> > +     /* C0-C7 line 32-47 */
> > +     "RSVD_RMC_GPIO3", "", "", "",
> > +     "", "", "", "",
> > +     "LEAK_DETECT_RMC_N", "JTAG_CPLD_TRST_R_N", "", "",
> > +     "", "", "", "",
> > +
> > +     /* D0-D7 line 48-63 */
> > +     "PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
> > +     "PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
> > +     "PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
> > +     "PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
> > +     "AMC_BRD_PRSNT_CPLD_L", "", "", "",
> > +     "", "", "", "",
> > +
> > +     /* E0-E7 line 64-79 */
> > +     "AMC_PDB_EAMHSC0_CPLD_EN_R", "",
> > +     "AMC_PDB_EAMHSC1_CPLD_EN_R", "",
> > +     "AMC_PDB_EAMHSC2_CPLD_EN_R", "",
> > +     "AMC_PDB_EAMHSC3_CPLD_EN_R", "",
> > +     "", "", "", "",
> > +     "", "", "", "",
> > +
> > +     /* F0-F7 line 80-95 */
> > +     "PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
> > +     "PWRGD_PVDDCR_CPU0_P0", "",
> > +     "", "", "", "",
> > +     "", "", "", "",
> > +
> > +     /* G0-G7 line 96-111 */
> > +     "L_PRSNT_EDSFF0_N", "",
> > +     "L_PRSNT_EDSFF1_N", "",
> > +     "R_PRSNT_EDSFF2_N", "",
> > +     "R_PRSNT_EDSFF3_N", "",
> > +     "HPM_EDSFF_PG", "",
> > +     "PWRGD_CHEH_CPU0_FPGA", "",
> > +     "PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
> > +     "", "",
> > +
> > +     /* H0-H7 line 112-127 */
> > +     "PWRGD_P3V3", "",
> > +     "P12V_DDR_IP_PWRGD_R", "",
> > +     "P12V_DDR_AH_PWRGD_R", "",
> > +     "PWRGD_P12V_VRM1_CPLD_PG_R", "",
> > +     "PWRGD_P12V_VRM0_CPLD_PG_R", "",
> > +     "PWRGD_PDB_HSC4_CPLD_PG_R", "",
> > +     "PWRGD_PVDD18_S5_P0_PG", "",
> > +     "PWRGD_PVDD33_S5_P0_PG", "",
> > +
> > +     /* I0-I7 line 128-143 */
> > +     "EAM0_BRD_PRSNT_R_L", "",
> > +     "EAM1_BRD_PRSNT_R_L", "",
> > +     "EAM2_BRD_PRSNT_R_L", "",
> > +     "EAM3_BRD_PRSNT_R_L", "",
> > +     "EAM0_CPU_MOD_PWR_GD_R", "",
> > +     "EAM1_CPU_MOD_PWR_GD_R", "",
> > +     "PRSNT_EDSFF_BOOT_N", "",
> > +     "EAM3_CPU_MOD_PWR_GD_R", "",
> > +
> > +     /* J0-J7 line 144-159 */
> > +     "PRSNT_L_BIRDGE_R", "",
> > +     "PRSNT_R_BIRDGE_R", "",
> > +     "BRIDGE_L_MAIN_PG_R", "",
> > +     "BRIDGE_R_MAIN_PG_R", "",
> > +     "BRIDGE_L_STBY_PG_R", "",
> > +     "BRIDGE_R_STBY_PG_R", "",
> > +     "", "", "", "",
> > +
> > +     /* K0-K7 line 160-175 */
> > +     "ADC_I2C_ALERT_N", "",
> > +     "TEMP_I2C_ALERT_R_L", "",
> > +     "CPU0_VR_SMB_ALERT_CPLD_N", "",
> > +     "COVER_INTRUDER_R_N", "",
> > +     "HANDLE_INTRUDER_CPLD_N", "",
> > +     "IRQ_MCIO_CPLD_WAKE_R_N", "",
> > +     "APML_CPU0_ALERT_R_N", "",
> > +     "PDB_ALERT_R_N", "",
> > +
> > +     /* L0-L7 line 176-191 */
> > +     "L_EDSFF0_PG", "", "L_EDSFF1_PG", "",
> > +     "R_EDSFF2_PG", "", "R_EDSFF3_PG", "",
> > +     "CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
> > +     "CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
> > +
> > +     /* M0-M7 line 192-207 */
> > +     "EAM0_SMERR_CPLD_R_L", "",
> > +     "EAM1_SMERR_CPLD_R_L", "",
> > +     "EAM2_SMERR_CPLD_R_L", "",
> > +     "EAM3_SMERR_CPLD_R_L", "",
> > +     "CPU0_SMERR_N_R", "",
> > +     "CPU0_NV_SAVE_N_R", "",
> > +     "PDB_PWR_LOSS_CPLD_N", "",
> > +     "IRQ_BMC_SMI_ACTIVE_R_N", "",
> > +
> > +     /* N0-N7 line 208-223 */
> > +     "AMCROT_BMC_S5_RDY_R", "",
> > +     "AMC_RDY_R", "",
> > +     "AMC_STBY_PGOOD_R", "",
> > +     "CPU_AMC_SLP_S5_R_L", "",
> > +     "AMC_CPU_EAMPG_R", "",
> > +     "", "", "", "",
> > +
> > +     /* O0-O7 line 224-239 */
> > +     "HPM_PWR_FAIL", "Port80_b0",
> > +     "FM_DIMM_IP_FAIL", "Port80_b1",
> > +     "FM_DIMM_AH_FAIL", "Port80_b2",
> > +     "AMC_THERMTRIP_ASSERT", "Port80_b3",
> > +     "CPU_THERMTRIP_ASSERT", "Port80_b4",
> > +     "PVDDCR_SOC_P0_OCP_L", "Port80_b5",
> > +     "CPLD_SGPIO_RDY", "Port80_b6",
> > +     "", "Port80_b7",
> > +
> > +     /* P0-P7 line 240-255 */
> > +     "CPU0_SLP_S5_N_R", "NFC_VEN",
> > +     "CPU0_SLP_S3_N_R", "",
> > +     "FM_CPU0_PWRGD", "",
> > +     "PWRGD_RMC", "",
> > +     "FM_RST_CPU0_RESET_N", "",
> > +     "FM_PWRGD_CPU0_PWROK", "",
> > +     "wS5_PWR_Ready", "",
> > +     "wS0_ON_N", "PWRGD_P1V0_AUX";
> > +     status =3D "okay";
> > +};
> > +
> > +// BIOS Flash
> > +&spi2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_spi2_default>;
> > +     status =3D "okay";
> > +     reg =3D <0x1e631000 0xc4>, <0x50000000 0x8000000>;
>
> Why do you overwrite the SPI2 memory size to 128MB only?
> Even if you use the other part for the TPM, you should not overwrite the
> memory
>
I think you find the issue. I will remove memory size overwrite


> region...
>
> +
> > +     flash@0 {
> > +             compatible =3D "jedec,spi-nor";
> > +             label =3D "pnor";
> > +             spi-max-frequency =3D <12000000>;
> > +             spi-tx-bus-width =3D <2>;
> > +             spi-rx-bus-width =3D <2>;
> > +             status =3D "okay";
> > +     };
> > +};
> > +
> > +// HOST BIOS Debug
> > +&uart1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart3 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart4 {
> > +     status =3D "okay";
> > +};
> > +
> > +// BMC Debug Console
> > +&uart5 {
> > +     status =3D "okay";
> > +};
> > +
> > +&uart_routing {
> > +     status =3D "okay";
> > +};
> > +
> > +&uhci {
> > +     status =3D "okay";
> > +};
> > +
> > +&vhub {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
>
> aspeed-g6.dtsi sets pinctrl-names to default already. Unnecessary...
>
I will remove this line.

>
> Tan
>
> --
> Tan Siewert <tan.siewert@9elements.com>
>
>

--0000000000004b405f0658ec0a1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"auto"><br><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Tan Siewert &lt=
;<a href=3D"mailto:tan.siewert@9elements.com" target=3D"_blank">tan.siewert=
@9elements.com</a>&gt; =E6=96=BC 2026=E5=B9=B48=E6=9C=888=E6=97=A5=E9=80=B1=
=E5=85=AD =E4=B8=8B=E5=8D=887:58 =E5=AF=AB=E9=81=93=EF=BC=9A<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi Colin,<br>
<br>
&gt; This change introduces a development-phase devicetree for the<br>
&gt; Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa<br=
>
&gt; wrapper DTS to reference it.<br>
<br>
<br>
&gt; <br>
&gt; A dedicated EVT1 DTS is added for revision-specific hardware while<br>
&gt; keeping a single, Anacapa entrypoint used by the build and deployment<=
br>
&gt; flow. The top-level aspeed-bmc-facebook-anacapa.dts<br>
&gt; <br>
&gt; Signed-off-by: Colin Huang &lt;<a href=3D"mailto:u8813345@gmail.com" r=
el=3D"noreferrer" target=3D"_blank">u8813345@gmail.com</a>&gt;<br>
<br>
<br>
<br>
<br>
&gt;<br>
&gt; diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1=
.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..a095be48a3fe<br>
&gt; --- /dev/null<br>
&gt; +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts<br=
>
<br>
`scripts/dtc/dt-check-style --mode strict` reports multiple errors:<br>
<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:10: [property-order] pro=
perty &#39;compatible&#39; out of canonical order (should sort before &#39;=
model&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:18: [property-order] pro=
perty &#39;i2c16&#39; out of canonical order (should sort before &#39;seria=
l4&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:71: [continuation-alignm=
ent] continuation should align to column 31 (under &quot;&lt;&quot; or \&qu=
ot;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:72: [continuation-alignm=
ent] continuation should align to column 31 (under &quot;&lt;&quot; or \&qu=
ot;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:80: [property-order] pro=
perty &#39;gpios&#39; out of canonical order (should sort before &#39;label=
&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:86: [property-order] pro=
perty &#39;default-state&#39; out of canonical order (should sort before &#=
39;label&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:93: [property-order] pro=
perty &#39;reg&#39; out of canonical order (should sort before &#39;device_=
type&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:99: [property-order] pro=
perty &#39;ranges&#39; out of canonical order (should sort before &#39;#siz=
e-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:103: [property-order] pr=
operty &#39;alignment&#39; out of canonical order (should sort before &#39;=
size&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:104: [property-order] pr=
operty &#39;compatible&#39; out of canonical order (should sort before &#39=
;alignment&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:108: [child-name-order] =
child node &#39;framebuffer&#39; out of name order<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:110: [property-order] pr=
operty &#39;alignment&#39; out of canonical order (should sort before &#39;=
size&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:111: [property-order] pr=
operty &#39;compatible&#39; out of canonical order (should sort before &#39=
;alignment&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:116: [child-name-order] =
child node &#39;regulator-p3v3-bmc-aux&#39; out of name order<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:116: [unused-labels] lab=
el &#39;p3v3_bmc_aux&#39; defined but never &amp;-referenced<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:119: [property-order] pr=
operty &#39;regulator-min-microvolt&#39; out of canonical order (should sor=
t before &#39;regulator-name&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:120: [property-order] pr=
operty &#39;regulator-max-microvolt&#39; out of canonical order (should sor=
t before &#39;regulator-min-microvolt&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:121: [property-order] pr=
operty &#39;regulator-always-on&#39; out of canonical order (should sort be=
fore &#39;regulator-max-microvolt&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:124: [unused-labels] lab=
el &#39;spi_gpio&#39; defined but never &amp;-referenced<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:129: [property-order] pr=
operty &#39;sck-gpios&#39; out of canonical order (should sort before &#39;=
#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:130: [property-order] pr=
operty &#39;mosi-gpios&#39; out of canonical order (should sort before &#39=
;sck-gpios&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:131: [property-order] pr=
operty &#39;miso-gpios&#39; out of canonical order (should sort before &#39=
;mosi-gpios&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:132: [property-order] pr=
operty &#39;cs-gpios&#39; out of canonical order (should sort before &#39;m=
iso-gpios&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:134: [required-blank-lin=
es] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:139: [property-order] pr=
operty &#39;reg&#39; out of canonical order (should sort before &#39;spi-ma=
x-frequency&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:146: [property-order] pr=
operty &#39;pinctrl-names&#39; out of canonical order (should sort before &=
#39;aspeed,int-vref-microvolt&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:147: [property-order] pr=
operty &#39;pinctrl-0&#39; out of canonical order (should sort before &#39;=
pinctrl-names&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:148: [continuation-align=
ment] continuation should align to column 21 (under &quot;&lt;&quot; or \&q=
uot;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:149: [continuation-align=
ment] continuation should align to column 21 (under &quot;&lt;&quot; or \&q=
uot;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:150: [continuation-align=
ment] continuation should align to column 21 (under &quot;&lt;&quot; or \&q=
uot;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:151: [required-blank-lin=
es] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:156: [property-order] pr=
operty &#39;pinctrl-names&#39; out of canonical order (should sort before &=
#39;aspeed,int-vref-microvolt&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:157: [property-order] pr=
operty &#39;pinctrl-0&#39; out of canonical order (should sort before &#39;=
pinctrl-names&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:158: [required-blank-lin=
es] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:170: [property-order] pr=
operty &#39;m25p,fast-read&#39; out of canonical order (should sort before =
&#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:171: [property-order] pr=
operty &#39;label&#39; out of canonical order (should sort before &#39;m25p=
,fast-read&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:178: [property-order] pr=
operty &#39;m25p,fast-read&#39; out of canonical order (should sort before =
&#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:179: [property-order] pr=
operty &#39;label&#39; out of canonical order (should sort before &#39;m25p=
,fast-read&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:186: [property-order] pr=
operty &#39;memory-region&#39; out of canonical order (should sort before &=
#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:314: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:321: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:326: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:331: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:354: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:361: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:366: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:371: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:388: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:395: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:400: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:405: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:410: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:415: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:420: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:425: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] conse=
cutive blank lines<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] blank=
 line at end of node body<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:465: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:482: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:487: [property-order] pr=
operty &#39;gpio-line-names&#39; out of canonical order (should sort before=
 &#39;interrupts&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:504: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:509: [property-order] pr=
operty &#39;gpio-line-names&#39; out of canonical order (should sort before=
 &#39;interrupts&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:527: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:536: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:541: [property-order] pr=
operty &#39;gpio-line-names&#39; out of canonical order (should sort before=
 &#39;interrupts&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:556: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:561: [property-order] pr=
operty &#39;gpio-line-names&#39; out of canonical order (should sort before=
 &#39;interrupts&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:578: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:583: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:617: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:624: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:629: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:634: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:639: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:644: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:653: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:672: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:677: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:694: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:701: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:706: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:711: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:716: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:721: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:730: [property-order] pr=
operty &#39;#gpio-cells&#39; out of canonical order (should sort before &#3=
9;gpio-controller&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:749: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:754: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:776: [property-order] pr=
operty &#39;i2c-mux-idle-disconnect&#39; out of canonical order (should sor=
t before &#39;#size-cells&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:783: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:788: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:793: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:804: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:815: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:820: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:825: [required-blank-lin=
es] child node must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:837: [property-order] pr=
operty &#39;enable-gpios&#39; out of canonical order (should sort before &#=
39;interrupts&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:854: [required-blank-lin=
es] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:859: [required-blank-lin=
es] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:868: [property-order] pr=
operty &#39;pinctrl-names&#39; out of canonical order (should sort before &=
#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:869: [property-order] pr=
operty &#39;pinctrl-0&#39; out of canonical order (should sort before &#39;=
pinctrl-names&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:875: [property-order] pr=
operty &#39;bus-frequency&#39; out of canonical order (should sort before &=
#39;ngpios&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1020: [property-order] p=
roperty &#39;pinctrl-0&#39; out of canonical order (should sort before &#39=
;pinctrl-names&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1021: [required-blank-li=
nes] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1022: [property-order] p=
roperty &#39;reg&#39; out of canonical order (should sort before &#39;statu=
s&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1029: [property-order] p=
roperty &#39;spi-rx-bus-width&#39; out of canonical order (should sort befo=
re &#39;spi-tx-bus-width&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1030: [required-blank-li=
nes] &quot;status&quot; must be preceded by a blank line<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1062: [property-order] p=
roperty &#39;pinctrl-names&#39; out of canonical order (should sort before =
&#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1067: [property-order] p=
roperty &#39;memory-region&#39; out of canonical order (should sort before =
&#39;status&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1072: [property-order] p=
roperty &#39;pinctrl-0&#39; out of canonical order (should sort before &#39=
;pinctrl-names&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1074: [property-order] p=
roperty &#39;aspeed,external-signal&#39; out of canonical order (should sor=
t before &#39;aspeed,reset-type&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1075: [property-order] p=
roperty &#39;aspeed,ext-push-pull&#39; out of canonical order (should sort =
before &#39;aspeed,external-signal&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1076: [property-order] p=
roperty &#39;aspeed,ext-active-high&#39; out of canonical order (should sor=
t before &#39;aspeed,ext-push-pull&#39;)<br>
=C2=A0 =C2=A0 aspeed-bmc-facebook-anacapa-evt1.dts:1078: [required-blank-li=
nes] &quot;status&quot; must be preceded by a blank line<br>
<br></blockquote><div>I will run this script and fix issues.</div><div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; @@ -0,0 +1,1079 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +/dts-v1/;<br>
&gt; +#include &quot;aspeed-g6.dtsi&quot;<br>
&gt; +#include &lt;dt-bindings/gpio/aspeed-gpio.h&gt;<br>
&gt; +#include &lt;dt-bindings/i2c/i2c.h&gt;<br>
&gt; +<br>
&gt; +/ {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0model =3D &quot;Facebook Anacapa BMC&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0compatible =3D &quot;facebook,anacapa-bmc-evt1&qu=
ot;, &quot;aspeed,ast2600&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0aliases {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial0 =3D &amp;uart=
1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial1 =3D &amp;uart=
2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial2 =3D &amp;uart=
3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial3 =3D &amp;uart=
4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial4 =3D &amp;uart=
5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c16 =3D &amp;i2c0mu=
x0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c17 =3D &amp;i2c0mu=
x0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c18 =3D &amp;i2c0mu=
x0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c19 =3D &amp;i2c0mu=
x0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c20 =3D &amp;i2c1mu=
x0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c21 =3D &amp;i2c1mu=
x0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c22 =3D &amp;i2c1mu=
x0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c23 =3D &amp;i2c1mu=
x0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c24 =3D &amp;i2c4mu=
x0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c25 =3D &amp;i2c4mu=
x0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c26 =3D &amp;i2c4mu=
x0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c27 =3D &amp;i2c4mu=
x0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c28 =3D &amp;i2c4mu=
x0ch4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c29 =3D &amp;i2c4mu=
x0ch5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c30 =3D &amp;i2c4mu=
x0ch6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c31 =3D &amp;i2c4mu=
x0ch7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c32 =3D &amp;i2c8mu=
x0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c33 =3D &amp;i2c8mu=
x0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c34 =3D &amp;i2c8mu=
x0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c35 =3D &amp;i2c8mu=
x0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c36 =3D &amp;i2c10m=
ux0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c37 =3D &amp;i2c10m=
ux0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c38 =3D &amp;i2c10m=
ux0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c39 =3D &amp;i2c10m=
ux0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c40 =3D &amp;i2c10m=
ux0ch4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c41 =3D &amp;i2c10m=
ux0ch5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c42 =3D &amp;i2c10m=
ux0ch6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c43 =3D &amp;i2c10m=
ux0ch7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c44 =3D &amp;i2c11m=
ux0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c45 =3D &amp;i2c11m=
ux0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c46 =3D &amp;i2c11m=
ux0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c47 =3D &amp;i2c11m=
ux0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c48 =3D &amp;i2c11m=
ux0ch4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c49 =3D &amp;i2c11m=
ux0ch5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c50 =3D &amp;i2c11m=
ux0ch6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c51 =3D &amp;i2c11m=
ux0ch7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c52 =3D &amp;i2c13m=
ux0ch0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c53 =3D &amp;i2c13m=
ux0ch1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c54 =3D &amp;i2c13m=
ux0ch2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c55 =3D &amp;i2c13m=
ux0ch3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c56 =3D &amp;i2c13m=
ux0ch4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c57 =3D &amp;i2c13m=
ux0ch5;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c58 =3D &amp;i2c13m=
ux0ch6;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c59 =3D &amp;i2c13m=
ux0ch7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0chosen {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout-path =3D &quot=
;serial4:57600n8&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iio-hwmon {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
iio-hwmon&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0io-channels =3D &lt;&=
amp;adc0 0&gt;, &lt;&amp;adc0 1&gt;, &lt;&amp;adc0 2&gt;, &lt;&amp;adc0 3&g=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&amp;adc0 4&gt;, &lt;&amp;adc=
0 5&gt;, &lt;&amp;adc0 6&gt;, &lt;&amp;adc0 7&gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&amp;adc1 2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0leds {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
gpio-leds&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0led-0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0label =3D &quot;bmc_heartbeat_amber&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpios =3D &lt;&amp;gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0linux,default-trigger =3D &quot;heartbeat&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0led-1 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0label =3D &quot;fp_id_amber&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0default-state =3D &quot;off&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpios =3D &lt;&amp;gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memory@80000000 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_type =3D &quot=
;memory&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x8000000=
0 0x80000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reserved-memory {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;1=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ranges;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0video_engine_memory: =
video {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0size =3D &lt;0x02c00000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0alignment =3D &lt;0x00100000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;shared-dma-pool&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reusable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_memory: framebuff=
er {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0size =3D &lt;0x01000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0alignment =3D &lt;0x01000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;shared-dma-pool&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reusable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p3v3_bmc_aux: regulator-p3v3-bmc-aux {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
regulator-fixed&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator-name =3D &q=
uot;p3v3_bmc_aux&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator-min-microvo=
lt =3D &lt;3300000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator-max-microvo=
lt =3D &lt;3300000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator-always-on;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spi_gpio: spi {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
spi-gpio&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;0=
&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sck-gpios =3D &lt;&am=
p;gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mosi-gpios =3D &lt;&a=
mp;gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0miso-gpios =3D &lt;&a=
mp;gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-gpios =3D &lt;&amp=
;gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num-chipselects =3D &=
lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay=
&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpm@0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;infineon,slb9670&quot;, &quot;tcg,tpm_tis-spi&q=
uot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0spi-max-frequency =3D &lt;33000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
<br>
*snip*<br>
<br>
&gt; +// AMC<br>
&gt; +&amp;i2c5 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +// MB<br>
&gt; +&amp;i2c6 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0// HPM FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0eeprom@50 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
atmel,24c256&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x50&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// SCM<br>
&gt; +&amp;i2c7 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +<br>
<br>
Unnecessary newlines.<br>
<br>
&gt; +};<br>
&gt; +<br>
&gt; +// MB - PDB<br>
&gt; +&amp;i2c8 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c-mux@72 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
nxp,pca9546&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x72&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;0=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-mux-idle-disconne=
ct;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c8mux0ch0: i2c@0 {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adc@1f {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;ti,adc128d818&quot;=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x1f&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ti,mode =3D /bits/ 8 &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@22 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x22&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;sgpiom0&gt=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;174 IRQ_TYPE_LEVEL_LO=
W&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_F=
AN_FULL_SPEED_R_N&quot;, &quot;RPDB_I2C_TEMP75_U8_ALERT_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_I=
2C_TMP432_U29_ALERT_R_N&quot;, &quot;RPDB_GLOBAL_WP&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_F=
AN_CT_FAN_FAIL_R_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_A=
LERT_P50V_HSC2_R_N&quot;, &quot;RPDB_ALERT_P50V_HSC3_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_A=
LERT_P50V_HSC4_R_N&quot;, &quot;RPDB_ALERT_P50V_STBY_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_I=
2C_P12V_MB_VRM_ALERT_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_I=
2C_P12V_STBY_VRM_ALERT_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
GD_P3V3_STBY_PWRGD_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
12V_STBY_VRM_PWRGD_BUF_R&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@24 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x24&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;sgpiom0&gt=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;174 IRQ_TYPE_LEVEL_LO=
W&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_E=
AM2_PRSNT_MOS_N_R&quot;, &quot;RPDB_EAM3_PRSNT_MOS_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
WRGD_P50V_HSC4_SYS_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
WRGD_P50V_STBY_SYS_BUF_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
50V_FAN1_R2_PG&quot;, &quot;RPDB_P50V_FAN2_R2_PG&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_P=
50V_FAN3_R2_PG&quot;, &quot;RPDB_P50V_FAN4_R2_PG&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
, &quot;RPDB_FAN1_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
, &quot;RPDB_FAN2_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RPDB_F=
AN3_PRSNT_N_R&quot;, &quot;RPDB_FAN4_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
, &quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0// R-PDB FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eeprom@50 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;atmel,24c128&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x50&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c8mux0ch1: i2c@1 {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@22 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x22&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;sgpiom0&gt=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;174 IRQ_TYPE_LEVEL_LO=
W&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_F=
AN_FULL_SPEED_R_N&quot;,&quot;LPDB_I2C_TEMP75_U8_ALERT_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_I=
2C_TMP432_U29_ALERT_R_N&quot;,&quot;LPDB_GLOBAL_WP&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_F=
AN_CT_FAN_FAIL_R_N&quot;,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_A=
LERT_P50V_HSC0_R_N&quot;,&quot;LPDB_ALERT_P50V_HSC1_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_A=
LERT_P50V_HSC5_R_N&quot;,&quot;LPDB_I2C_P12V_SW_VRM_ALERT_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_E=
AM0_PRSNT_MOS_N_R&quot;,&quot;LPDB_EAM1_PRSNT_MOS_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_P=
WRGD_P50V_HSC5_SYS_R&quot;,&quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@24 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x24&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;sgpiom0&gt=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;174 IRQ_TYPE_LEVEL_LO=
W&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_P=
50V_FAN1_R2_PG&quot;,&quot;LPDB_P50V_FAN2_R2_PG&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_P=
50V_FAN3_R2_PG&quot;,&quot;LPDB_P50V_FAN4_R2_PG&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_P=
50V_FAN5_R2_PG&quot;,&quot;LPDB_FAN1_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_F=
AN2_PRSNT_N_R&quot;,&quot;LPDB_FAN3_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LPDB_F=
AN4_PRSNT_N_R&quot;,&quot;LPDB_FAN5_PRSNT_N_R&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0// L-PDB FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eeprom@50 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;atmel,24c128&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x50&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c8mux0ch2: i2c@2 {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c8mux0ch3: i2c@3 {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;3&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// SCM<br>
&gt; +&amp;i2c9 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0// SCM FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0eeprom@50 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
atmel,24c128&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x50&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0// BSM FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0eeprom@56 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
atmel,24c64&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x56&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// R Bridge Board<br>
&gt; +&amp;i2c10 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c-mux@71 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
nxp,pca9548&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x71&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;0=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-mux-idle-disconne=
ct;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch0: i2c@0 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch1: i2c@1 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch2: i2c@2 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch3: i2c@3 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;3&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch4: i2c@4 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch5: i2c@5 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;5&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@22 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x22&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;RBB_CPLD_REFRESH_IN_PRGRS_R_L&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RBB_EA=
M0_NIC_CBL_PRSNT_R_L&quot;,&quot;RBB_EAM1_NIC_CBL_PRSNT_R_L&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RBB_AI=
NIC_JTAG_MUX_R2_SEL&quot;,&quot;RBB_SPI_MUX0_R2_SEL&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RBB_AI=
NIC_PRSNT_R_L&quot;,&quot;RBB_AINIC_OE_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RBB_AI=
NIC_BOARD_R2_ID&quot;,&quot;RBB_RST_USB2_HUB_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;RBB_RS=
T_FT4222_R_N&quot;,&quot;RBB_RST_MCP2210_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0// R Bridge Board FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eeprom@52 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;atmel,24c256&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x52&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch6: i2c@6 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;6&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c10mux0ch7: i2c@7 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;7&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// L Bridge Board<br>
&gt; +&amp;i2c11 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c-mux@71 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
nxp,pca9548&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x71&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;0=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-mux-idle-disconne=
ct;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch0: i2c@0 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch1: i2c@1 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch2: i2c@2 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch3: i2c@3 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;3&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch4: i2c@4 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch5: i2c@5 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;5&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0gpio@22 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,pca9555&quot;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x22&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-controller;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#gpio-cells =3D &lt;2&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;LBB_CPLD_REFRESH_IN_PRGRS_R_L&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LBB_EA=
M0_NIC_CBL_PRSNT_R_L&quot;,&quot;LBB_EAM1_NIC_CBL_PRSNT_R_L&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LBB_AI=
NIC_JTAG_MUX_R2_SEL&quot;,&quot;LBB_SPI_MUX0_R2_SEL&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LBB_AI=
NIC_PRSNT_R_L&quot;,&quot;LBB_AINIC_OE_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LBB_AI=
NIC_BOARD_R2_ID&quot;,&quot;LBB_RST_USB2_HUB_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;LBB_RS=
T_FT4222_R_N&quot;,&quot;LBB_RST_MCP2210_R_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;=
,&quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0// L Bridge Board FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eeprom@52 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;atmel,24c256&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x52&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch6: i2c@6 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;6&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c11mux0ch7: i2c@7 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;7&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// Debug Card<br>
&gt; +&amp;i2c12 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +// MB<br>
&gt; +&amp;i2c13 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i2c-mux@70 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
nxp,pca9548&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x70&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;0=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c-mux-idle-disconne=
ct;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch0: i2c@0 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch1: i2c@1 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch2: i2c@2 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch3: i2c@3 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;3&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adc@1f {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;ti,adc128d818&quot;=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x1f&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ti,mode =3D /bits/ 8 &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch4: i2c@4 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0// HPM BRD ID FRU<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eeprom@51 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;atmel,24c256&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x51&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch5: i2c@5 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;5&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch6: i2c@6 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;6&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c13mux0ch7: i2c@7 {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0reg =3D &lt;7&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0#size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nfc@28 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;nxp,nxp-nci-i2c&quo=
t;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x28&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;sgpiom0&gt=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;156 IRQ_TYPE_LEVEL_HI=
GH&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable-gpios =3D &lt;&amp;sgpiom0 241 GP=
IO_ACTIVE_HIGH&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// SCM<br>
&gt; +&amp;i2c14 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;i2c15 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;kcs2 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0aspeed,lpc-io-reg =3D &lt;0xca8&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;kcs3 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0aspeed,lpc-io-reg =3D &lt;0xca2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;lpc_ctrl {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;mac2 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pinctrl-0 =3D &lt;&amp;pinctrl_ncsi3_default&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0use-ncsi;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;sgpiom0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ngpios =3D &lt;128&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bus-frequency =3D &lt;2000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio-line-names =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*in - out - in - out */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* A0-A7 line 0-15 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;FM_CPU0_SYS_RESET_N&quot;, &q=
uot;&quot;, &quot;CPU0_KBRST_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;FM_CPU0_PROCHOT_trigger_N&quo=
t;, &quot;&quot;, &quot;FM_CLR_CMOS_R_P0&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;Force_I3C_SEL&quot;, &quot;&q=
uot;, &quot;SYSTEM_Force_Run_AC_Cycle&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* B0-B7 line 16-31 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel0_leakage_EAM3&quot;, &quot;FM_CPU_F=
PGA_JTAG_MUX_SEL&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel1_leakage_EAM0&quot;, &quot;FM_SCM_J=
TAG_MUX_SEL&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel2_leakage_Manifold1&quot;, &quot;FM_=
BRIDGE_JTAG_MUX_SEL&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel3_leakage&quot;, &quot;FM_CPU0_NMI_S=
YNC_FLOOD_N&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel4_leakage_Manifold2&quot;, &quot;&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel5_leakage_EAM1&quot;, &quot;&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel6_leakage_CPU_DIMM&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;Channel7_leakage_EAM2&quot;, &quot;&quot;,<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* C0-C7 line 32-47 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;RSVD_RMC_GPIO3&quot;, &quot;&quot;, &quot;&=
quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;LEAK_DETECT_RMC_N&quot;, &quot;JTAG_CPLD_TR=
ST_R_N&quot;, &quot;&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* D0-D7 line 48-63 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PDB_EAMHSC0_CPLD_PG_R&quot;, &quot;&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PDB_EAMHSC1_CPLD_PG_R&quot;, &quot;&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PDB_EAMHSC2_CPLD_PG_R&quot;, &quot;&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PDB_EAMHSC3_CPLD_PG_R&quot;, &quot;&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_BRD_PRSNT_CPLD_L&quot;, &quot;&quot;, &=
quot;&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* E0-E7 line 64-79 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_PDB_EAMHSC0_CPLD_EN_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_PDB_EAMHSC1_CPLD_EN_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_PDB_EAMHSC2_CPLD_EN_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_PDB_EAMHSC3_CPLD_EN_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* F0-F7 line 80-95 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PVDDCR_CPU1_P0&quot;, &quot;SGPIO_REA=
DY&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PVDDCR_CPU0_P0&quot;, &quot;&quot;,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* G0-G7 line 96-111 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;L_PRSNT_EDSFF0_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;L_PRSNT_EDSFF1_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;R_PRSNT_EDSFF2_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;R_PRSNT_EDSFF3_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;HPM_EDSFF_PG&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_CHEH_CPU0_FPGA&quot;, &quot;&quot;,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_CHAD_CPU0_FPGA&quot;, &quot;FM_BMC_RE=
ADY_PLD&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* H0-H7 line 112-127 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_P3V3&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;P12V_DDR_IP_PWRGD_R&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;P12V_DDR_AH_PWRGD_R&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_P12V_VRM1_CPLD_PG_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_P12V_VRM0_CPLD_PG_R&quot;, &quot;&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PDB_HSC4_CPLD_PG_R&quot;, &quot;&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PVDD18_S5_P0_PG&quot;, &quot;&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_PVDD33_S5_P0_PG&quot;, &quot;&quot;,<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* I0-I7 line 128-143 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM0_BRD_PRSNT_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM1_BRD_PRSNT_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM2_BRD_PRSNT_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM3_BRD_PRSNT_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM0_CPU_MOD_PWR_GD_R&quot;, &quot;&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM1_CPU_MOD_PWR_GD_R&quot;, &quot;&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PRSNT_EDSFF_BOOT_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM3_CPU_MOD_PWR_GD_R&quot;, &quot;&quot;,<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* J0-J7 line 144-159 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PRSNT_L_BIRDGE_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PRSNT_R_BIRDGE_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;BRIDGE_L_MAIN_PG_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;BRIDGE_R_MAIN_PG_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;BRIDGE_L_STBY_PG_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;BRIDGE_R_STBY_PG_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* K0-K7 line 160-175 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;ADC_I2C_ALERT_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;TEMP_I2C_ALERT_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_VR_SMB_ALERT_CPLD_N&quot;, &quot;&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;COVER_INTRUDER_R_N&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;HANDLE_INTRUDER_CPLD_N&quot;, &quot;&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;IRQ_MCIO_CPLD_WAKE_R_N&quot;, &quot;&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;APML_CPU0_ALERT_R_N&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PDB_ALERT_R_N&quot;, &quot;&quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* L0-L7 line 176-191 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;L_EDSFF0_PG&quot;, &quot;&quot;, &quot;L_ED=
SFF1_PG&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;R_EDSFF2_PG&quot;, &quot;&quot;, &quot;R_ED=
SFF3_PG&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_CORETYPE0&quot;, &quot;&quot;, &quot;C=
PU0_CORETYPE1&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_CORETYPE2&quot;, &quot;&quot;, &quot;F=
M_BIOS_POST_CMPLT_R_N&quot;, &quot;&quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* M0-M7 line 192-207 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM0_SMERR_CPLD_R_L&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM1_SMERR_CPLD_R_L&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM2_SMERR_CPLD_R_L&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;EAM3_SMERR_CPLD_R_L&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_SMERR_N_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_NV_SAVE_N_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PDB_PWR_LOSS_CPLD_N&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;IRQ_BMC_SMI_ACTIVE_R_N&quot;, &quot;&quot;,=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* N0-N7 line 208-223 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMCROT_BMC_S5_RDY_R&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_RDY_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_STBY_PGOOD_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU_AMC_SLP_S5_R_L&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_CPU_EAMPG_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;&quot;, &quot;&quot;, &quot;&=
quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* O0-O7 line 224-239 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;HPM_PWR_FAIL&quot;, &quot;Port80_b0&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;FM_DIMM_IP_FAIL&quot;, &quot;Port80_b1&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;FM_DIMM_AH_FAIL&quot;, &quot;Port80_b2&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;AMC_THERMTRIP_ASSERT&quot;, &quot;Port80_b3=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU_THERMTRIP_ASSERT&quot;, &quot;Port80_b4=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PVDDCR_SOC_P0_OCP_L&quot;, &quot;Port80_b5&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPLD_SGPIO_RDY&quot;, &quot;Port80_b6&quot;=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&quot;, &quot;Port80_b7&quot;,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* P0-P7 line 240-255 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_SLP_S5_N_R&quot;, &quot;NFC_VEN&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;CPU0_SLP_S3_N_R&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;FM_CPU0_PWRGD&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;PWRGD_RMC&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;FM_RST_CPU0_RESET_N&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;FM_PWRGD_CPU0_PWROK&quot;, &quot;&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;wS5_PWR_Ready&quot;, &quot;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;wS0_ON_N&quot;, &quot;PWRGD_P1V0_AUX&quot;;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +// BIOS Flash<br>
&gt; +&amp;spi2 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pinctrl-0 =3D &lt;&amp;pinctrl_spi2_default&gt;;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg =3D &lt;0x1e631000 0xc4&gt;, &lt;0x50000000 0=
x8000000&gt;;<br>
<br>
Why do you overwrite the SPI2 memory size to 128MB only?<br>
Even if you use the other part for the TPM, you should not overwrite the me=
mory<br></blockquote><div>I think you find the issue. I will remove memory =
size overwrite=C2=A0<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
region...<span style=3D"background-color:transparent">=C2=A0</span><br></bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0flash@0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
jedec,spi-nor&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0label =3D &quot;pnor&=
quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-max-frequency =3D=
 &lt;12000000&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-tx-bus-width =3D =
&lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spi-rx-bus-width =3D =
&lt;2&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay=
&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +};<br>
&gt; +<br>
&gt; +// HOST BIOS Debug<br>
&gt; +&amp;uart1 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;uart3 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;uart4 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +// BMC Debug Console<br>
&gt; +&amp;uart5 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;uart_routing {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;uhci {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +};<br>
&gt; +<br>
&gt; +&amp;vhub {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
<br>
aspeed-g6.dtsi sets pinctrl-names to default already. Unnecessary...<br></b=
lockquote><div>I will remove=C2=A0this line.=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Tan<br>
<br>
-- <br>
Tan Siewert &lt;<a href=3D"mailto:tan.siewert@9elements.com" rel=3D"norefer=
rer" target=3D"_blank">tan.siewert@9elements.com</a>&gt;<br><br>
</blockquote></div></div>
</div>

--0000000000004b405f0658ec0a1d--

