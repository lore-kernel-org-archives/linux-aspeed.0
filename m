Return-Path: <linux-aspeed+bounces-80-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75CAD3176B
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 17:35:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xjb7n63v7z2xJy;
	Wed,  6 Nov 2024 04:35:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730828101;
	cv=none; b=Z66q+HTH37+yM2DULkNKUabYG7aEN5/CyhkvMzRqsRAZENDM4LzJI5DN+gYmdtOHkXHNcnn/Z7nOiA17/QWyO4b5J0AUlpRN6e1Bt1x/OdHom6l3s40J5FOoclOw+E4pcvAZMtL9WP0jhXfsegqVciFdBD5PsYXDR/7cFVNIOPmgNePiznWKjr3NgcFLZ7m0MrwaIOrBpg8HDaoExL2VvK96XMHfqfKDh6U7rUqC8JmhSk3jzUY+/C5OtqABAgVUwKWIBehZ5qCSWQbMCeDj6d2PmaMw900mry4N8P6vt8F9xShmKW/v97o+ZkHGADg987sFss6MpBFd/lht7UjCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730828101; c=relaxed/relaxed;
	bh=SpVxQLLNLfLph3m6EIkv3r8u00CnaqvwEZ6ejt8Iwfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfkHnTSHG6enmXm0BpYIeJGJrU1HYgJSuee3k7i2J+j00q581nWZJi63A/2zD8X648O3l+u7YC/2uYC/oliTPHX2opCHq1OL9b7OXNgvP0kjXxO9toLWRbt2vavOil9T9XC6ENem0kSK2ENi26lbQJCSCtd8vcUk+XJvSazxghX7zeQ0qs6HUE9liX7/9a1LSQZr0lGTa0K26Qd7QOoFRaw6VwxLm2yhomXzLcnONcd1VneYue1n6HXd3C6d74fkDZDaxoX9C279k0Y/zxp4cTl72fHjXF/JmzzsT/EgTulN53RXA8vYQ7dv+8AHDgSGZHU9j4h/1qN/oRFAokZLoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Tu6s5Pc6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Tu6s5Pc6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=naresh.solanki@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xjb7l4NRmz2xHQ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 04:34:57 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3880693a12.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 05 Nov 2024 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730828095; x=1731432895; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpVxQLLNLfLph3m6EIkv3r8u00CnaqvwEZ6ejt8Iwfo=;
        b=Tu6s5Pc6HtgKLIcDc3eXjEzbNGR5fkuc/h6mk9HZ6sd0C4ApCmcuqrkKaTpqfJ5iNH
         P9oE/4XsiQiITQEopLXBy1QYmxx5IyXWw9VPqzpK/KzqDj8TbKyiL1vrfQ4xbGTId+Uj
         HFnkdpWcUUgQLWijP+LaJE8ktBuueozT6erQi/OXjQIMvaTol61+HXFouKp49ucFAZ1n
         BKUGx00ImBAJnphSfMHZo89m0MnvvLAPRJhnMJ7kOPqAdNpqM3TmF5cp+m4qEdcma06K
         Hj7g3H5EZomKCv14tBUb2QjXp+DZZTIOWoU2VMvrRzBFdB9fVEXcYYAcjl3shRoGOY9m
         XhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828095; x=1731432895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpVxQLLNLfLph3m6EIkv3r8u00CnaqvwEZ6ejt8Iwfo=;
        b=JVu1hMBSjmGfvH57WDdnDdex8shFSa7E9Hse7xAIWUeEGB2ms1mi/d13rTL13V6kOO
         nwKIbAyFOHVaCkllLdltkckVtq04yN/mNvAcaPvm0SyJUS56s3G39Yrn2vnGWMMRhMn7
         hLW5Lf2sOdi68Ovt/FexsOf6A0o4boKYgIdZRQf6n+4Jkqc+HDmde3BGKGQ2aHtmmoku
         54BfxGEcOLetEQRXAHGu1TN+prIRNxTrqI18Ji++Y/sspjMPTroTyMUHabp0xNaBCOoC
         JiQUQYtNwt/Ki+Gjjx62xU7azINqFnmbocYM8lS7KKOl6UUmsqV2T/nNl5aIGSfbLS+I
         5WtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz27ZISsUvGy+Pfd3240eaxIyFNTlue+12YorHnnIH6OwV3AeR9Bkf+w7rZlg6OKXZHSRiL8K9ouqvIek=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YweoZyyERRWpKf6FkpfEtz4uBJ/HgVKVsRqg2Mz68XOCcIN9bdl
	EMYjhu++GKwPfV45namYCBigF7ynhnte9Tb2PtPjIcA535N8kxFbblfIxupTsr5PGK6sPw6Z1vD
	QUi5RPOOscax92lPe2NgZkP9JszxN0CHb+tflXQ==
X-Google-Smtp-Source: AGHT+IH+bA1GiURFitv8kWYaSx/RW5cqeoyKLHZlSyIHFiiS2c0gxrHtSJy3vziWV/X5vWRNJ0DWzAshOtbMqV8BLE0=
X-Received: by 2002:a17:90b:3581:b0:2e0:7b2b:f6a with SMTP id
 98e67ed59e1d1-2e92ce710a9mr24650088a91.17.1730828095207; Tue, 05 Nov 2024
 09:34:55 -0800 (PST)
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
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <20241104092220.2268805-2-naresh.solanki@9elements.com> <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com> <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
In-Reply-To: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 5 Nov 2024 23:04:44 +0530
Message-ID: <CABqG17i51TnPhAKKEAVYMXfqem9XWeNJuwzgLiYB81uCs0n91A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jdelvare@suse.com, sylv@sylv.io, linux-hwmon@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>, Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew, Guenter,

@Andrew Shall I resend this patch series along with dependent
dt-binding patches ?

On Tue, 5 Nov 2024 at 21:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/4/24 20:10, Naresh Solanki wrote:
> [ ... ]
>
> >>  From a spot check, the warnings seem legitimate. Did you send the right
> >> patches?
> > Just checked again. They are resolved. But I guess the dtbinding patch
> > for the above warning are merged in hwmon-next branch & not in dt/next
> >
>
> Did I apply some patches which should have been applied elsewhere ?
I think it should be fine.

Regards,
Naresh
>
> If so, please let me know, and I'll drop them.
>
> Guenter
>

