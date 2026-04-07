Return-Path: <linux-aspeed+bounces-3865-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6DB105D98A
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2JB5brvz2ygY;
	Wed, 08 Apr 2026 09:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775552727;
	cv=pass; b=VqRckWpctHAYfgEjCaSQdZoZotZOqNnRv+7FSF9recJJh1LNzAedOLvVovbZx6ontIQaZU/laINaLqxkcJ6c7Y5qxpn3d6gbXC8Vf9Cu3IO4TFOXwnaqZkCpy6Yw7vyUPe9WK6RLW0Uk7UgfA4bcv6zCW9NNH5P8+IhHAvUk0NhtyvZ46cGvqzk5ZIINUqmtyIwdIHOw79PKNPBWaWcHQrrjBvH8isniGHzuh2U9bcutN6tnuW9FACbPI6o1Kq1ebV13ogObx5o0BODXcs+yRRIRfBXjcyOW8UtfOSh3/FbbZXG+wXSYceZJ5MvaTcrqhjwoc10WBlyLXbRBYQs6rw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775552727; c=relaxed/relaxed;
	bh=IyeaVeCxfhnKWP2l9xAwx/3zDkoSerhyFLbIvFQP+0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf947lfqi1HbN8ytLeJ9O7UNh7y5iRtL/7BXh9ygXbtBgwPJcYGVy/boTi43bIUhzY4/k/A++iGKIo0FDB0yTbNrWHOq3g6oeVLmWLE2bFRqxniWkC6rEgop7as3o/tZsedmILWbAKehp6KlpcmlCJ2Gl8L1ghpDTsDOKjpwORojTD1JKqRKZvF+WoFozF6OR3AWoY/sWe/9suGHevHwdAuoOchUI/joyRE/5SA61mWovzAe0psqS2xhqHQ7OMoVQOsHRlBrQKsziu0MZxtSLZoPxrXduXlbqCwe8qD8091dKxQLwFw5/+JcjBO0v5SNfsTCwcL62IF7n2eYz+il8A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IUXcYR8E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IUXcYR8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqgJk3gJLz2ySk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 19:05:25 +1000 (AEST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-7dbf23885dfso606234a34.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 02:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775552723; cv=none;
        d=google.com; s=arc-20240605;
        b=PMP41CRBwd+y2hEhk9Gax+u3g2WHxaZ7i59NVHcr3ce3/YpBvNXqDjRu8TluFkQB5c
         MAjqJI8j3dl8sTY6AnfnlLK4L8nENZKxpEvpHuC9aiyDCEDedmjseJzhlIujoXWOLqtr
         R9nYup1gva4zp4My+adVlanPT/cTIM018Zly7XhVyWU5B143s1lC6MeHiPyafquYrrzS
         ITG/K3XntvatY12NQ/t9rQw7OL+LjVkeIYGizyngsd3eLEAHTjZid7KTric54MC6WNp7
         t5sfthYNPXnJZoFg9QM0F/32PER7jSpIdiS1SiFWZTC8j7H5LVWqkv5OGgVhbNEEFSp5
         Cr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IyeaVeCxfhnKWP2l9xAwx/3zDkoSerhyFLbIvFQP+0Y=;
        fh=M8S1sx/zAxs1/O+oXE+ZcBZkvKYd2SnZSezymMrVv/o=;
        b=dFBNCTGfjhIgDBrn8Ffeyw0jlo0vggAjgMpGuhI8Gxp6sn1xVk3HUj+bUvSchAL7Si
         YmUjweGc0WLzhN0iJrlgOTI27kzcBuzV/g3f54TLw2Xhxqh87id75AkzMmsp4CFeYQuZ
         2yLmAB6xYT63ZiT+uYc0FOMQBFEpW8JP5VpTZg31r7aEy/8nGkEXuLLmO2lBDCKX+l4E
         a7aw2TfMC/SDbQZFsPuUbnMgZLgfEFX+0p1XTzzv7cnMGAqozCKWe6KZzFGbcggOZGpi
         t/iPnPWPLKXuVyoZU/eOwFxEehKZTBjxiSTxC26wTdQYM9OAnZgI7tfoLFKvWlfzGPnb
         RMmQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552723; x=1776157523; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IyeaVeCxfhnKWP2l9xAwx/3zDkoSerhyFLbIvFQP+0Y=;
        b=IUXcYR8EBWQAeUsLiT1xutYUYXw59XbeKV0+aSDhdog5PJxLzbkUG0l4DLkcUKVVcl
         vKIinQmbYTuHQdmEVEOetBFSwYALRFoA2uWIVbuOOURc06EE0Ng+lYWvXMGJAj/VsJSM
         HIUvntrjypNfTXLYJ+bVBPtgprZVFj02J9/vVLGeDoeqY0PUkV7De5T8/BpNXyfGEyQL
         FH5diQZz2nd8/sFj4CXS0zNtVo3avJGjyJErjmN1XE8JMPznbe6CraIxqYZlxZ9tzfuJ
         4dbhUGybJC6+mCEDTqkyzbnMd5fSqcueAKeALG3u7QPFjukGYTHmsoXa8PkiynJ/aan6
         Wu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552723; x=1776157523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyeaVeCxfhnKWP2l9xAwx/3zDkoSerhyFLbIvFQP+0Y=;
        b=UQ7MtJhKP8XTWdaoQ5CDcssoZiL0G3bp7ItHhSzMHEPPaQPQDgRqRLp8tt9m413TiI
         8ZxCd/6x4ga4X/h7f4WjyORl/OuS89+sLjT0R8T/K7vx3wdlz+7eZzP9fkacEkj3okzF
         fxsfB7uYurOPIE0Pq6Tb14SO9rfPKMYBS00rqj3GKuh9CSCFrtK+qLTTm5a3u3CF1Ntm
         5Sfnkoo62DSN48NLfHOEDij+i0X828JcoYrIJTAUCDQY8AJ/QRmdD2S+65DKVowWpLKl
         GNKTw/VSpNcpshAahv7UkISqPWr/7jpepkTbvOlOLuxs8gBKPke9QRil8CxoRb3SSmYN
         hRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqgj5kFujQAImiYqzKe4Zzq9zKenNGF4ARyCFgllAQKMhdIpqPuzrZD64rCffgN9E5lOoruYT5DV/AsuQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxng+94FiLshiCiOqc1A1sBAF+0JPHObt9l3nLXyTbnFhwHnP3N
	uKqO/HRElRofSLH/9DbRacUEwlu4rrAOIE9B6Cp5UM1iETEANCQA3RiUY24QSwKgESj7Y2/SSma
	W2UZMgFVHRU4fYh9NApEaf8aafGzItmo=
X-Gm-Gg: AeBDiesIamPRhdVtIrmGRR/c1v7udCaLQ+nh9lDm+FTrITeOZwXV58/2lBOYBYMsPsf
	yrx7q8avxAeuHPDgxB6SDwO2U4CcN6QiEvpwrfVv4lb1CFBoKxeD7CNnKzYY2YXMpbxqDBrdjVk
	Qo5P/SRsNdI/H87jFaKdZLTn4gngCig6Nc3JgVeAHT16BqHEAjT47P0xkVCoEssBoQVmhn5A0Ae
	Iq38oZprOroLcZGtmnlPVtAsQEC9XE6JerdMhAuZM/fdKZnw2YvDCvrzw0cnLs40E1QGAjfYEFM
	ULjCVIRN9LkczV2uLrk=
X-Received: by 2002:a05:6820:a0c:b0:679:88aa:7531 with SMTP id
 006d021491bc7-68220c43581mr8109352eaf.62.1775552723620; Tue, 07 Apr 2026
 02:05:23 -0700 (PDT)
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
References: <20260226055521.1655243-1-pkleequanta@gmail.com>
 <20260226055521.1655243-3-pkleequanta@gmail.com> <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
In-Reply-To: <258747f4-9da5-44da-8eb9-24f8a8cbff3a@lunn.ch>
From: PK Lee <pkleequanta@gmail.com>
Date: Tue, 7 Apr 2026 17:05:12 +0800
X-Gm-Features: AQROBzAu9EPCeu7yAg6nFPgvrkXGV_brWEzr82YVFUVRgLOpe60s_tcEts7ZUn0
Message-ID: <CAK8yEODCyYxkggU+7=xzWFcXP6RMTpNbHyYRHZhahX7=b6reqA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Content-Type: text/plain; charset="UTF-8"

> > +&mac3 {
> > +     status = "okay";
> > +     phy-mode = "rmii";
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_rmii4_default>;
> > +     fixed-link {
> > +             speed = <100>;
> > +             full-duplex;
> > +     };
>
> What is on the other end of this fixed link?

The other end of this fixed link is the CPU port of a Marvell 88E6393X
switch. We are using this switch in unmanaged mode rather than using
the DSA subsystem. Therefore, we use a fixed-link to force the mac3 to
100Mbps full-duplex RMII to match the CPU port configuration.

>
> > +};
> > +
> > +&mdio0 {
> > +     status = "okay";
> > +};
>
> If there are no devices on the bus, why enable it?

We intentionally enable it so user-space tools can access the switch
registers. I have added a comment in v13 to clarify this.

>
>    Andrew

P.K. Lee

