Return-Path: <linux-aspeed+bounces-130-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B00D68BC8
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Nov 2024 15:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqgmT0wTmz30Sx;
	Sat, 16 Nov 2024 02:24:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731684265;
	cv=none; b=oNCWmNe9BE2TgzBWVzXAMn9H2EjeBpPpHuLoyz2Pyo+jfO5DxRxVtBGRyCuzbGKzstxe+jAg7QQv8A5Id0WjcQcWfvC+vnxNuGTZxKmlNZA0kK6uJJfcNhc+Ounlohwf6OR+MLkHxUMZtp73llazQ75pb0zFHj2dyoO1cjI6ef6bMR5vUy6Ls+UPmzSjPeg+3BYnlbfQ3ewYMhXMDa+xgdJF19hm4HLI65IdfSt35jpJZT96vVjZ9o9eOHbXjd6IHs/x+K1IjSsk04eGwGMO/utRNjQ/gaJRlMfwQXrJIdkv5F6HTwuy2cNvbHR7CHvUW2xCHvB8AwGKuPLu5Tyy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731684265; c=relaxed/relaxed;
	bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eOvA2sU7+HTcnAvHg01fZPc+fXiBpIDov+g1TLmiHjsJqOb+7wB6odTuOmdatnGQKLv7L2K85c2g/MuXGr0n0xBczFrZPQQCAFuolmLsOETxkbxYi35/woZVdonEQl3BwL9nQttOeYE0LYakDckGgvyHe0EVgk3UIjR4oiyAV6dnWlDSt3ButTqmq3vDFCBB0kDbYz9hQ2TTN1MZeHfWjbo6Gz++/lH0zmLBEkofZXl3oHqzSbD2zn1xfHTivdysEqWYVjEYcO+GjJqSCwkc1YBnCMGJ7ifz/eeI49HpBldEPZ/AfzAdsGhn/6XcQ3v5kYNXxPllLJM5XTiVBqpmjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=dpL+bT6Z; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=brendanhiggins@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=dpL+bT6Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=brendanhiggins@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqgmQ5jb3z2yN2
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Nov 2024 02:24:21 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5cf6f5d4939so8400a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Nov 2024 07:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731684258; x=1732289058; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
        b=dpL+bT6ZwPL/F55EgQQi7iwxD1rRbDk4tjz3y9qiz2vL0QkucRgbTzk7kMVNqMz88M
         xIX8FHHB2FXruKj9viX8Jg7K4bE1nsnWLYF1XuZIxf6TMS7wiC44X8EqxOlWkFF0nrW/
         MrXGOcb43wC0Jvj0RtjXQKuqBLhxuZNckg1w1deSmr1ZjkCzDwJlUEreM9dCrpAFVvB4
         LShFU8ySkOX3+m76XmFN/nKB+qs5Y0iVOEkKQPuMqAdPki3caHRVw6SNRJAH/JJfQ7vV
         n2aXYykCAQhOjqCt46Ne/qLvv38YBd24v5XELUdmGwBVIgTZ/m0A6g3lx5AD9OBrSDkE
         IXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684258; x=1732289058;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CbonmGIEt1LytS/5LcyBBLPi6YyB8nOYoG0UOl1eSo=;
        b=m3vKdXMz6AIY34aDJ8LM64mzAD0+ljXE8ll9r1WzpY4rpgwsDu/motzLPsflbQQbhW
         UpgppYxpv+hWy0LMsaAL0ZDFbaD/NBujRTfixMqyWgvYNSPfaQNPVfO0tjpz2CEr86f9
         Yk9njhZTMLZJdy3U02gFmuvDas6ZzzP9EeUg+KNpAp4rMWYYyySwExjlvJ+kWlUYY4B7
         rIhv7lrfDKTv0/Pr6UgmlKuNV8IntcoQAYkYo3UNoZFiuFhWCgK9WA7QgAF4hS6i44zM
         1Gx6CNipTOOJFwbgIFq+hho2tWKwKlD9WdAzn/6xyUo9WhmWQR9bcGiFyH4uYD5cRBfK
         yqbA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Npa5qPW8dfjlPaFyP7XeoegAG4m2K4UaylAaqr3sW/CJhr1wcR+iaZr/Eip1fbRCggI2T0Uz4IUt7jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMH0rZg+3A4jFUEuRwyrIcSQ8C6rrTHMUVJfcnCAdjjU87qoYz
	Mp6/b1JZdg0itXEvoIMQYk6z2IwJrHfyT6/oAwwGZoE0HdLMQeHEzB5ji1lLnlUwE6VICBnAb6V
	0kurMvCinPQr5ZhEmf8GrPoyHstiwlqNwOKXu
X-Gm-Gg: ASbGncsi9BgbBgPuEj2erOLE7c+X/ZtrLYew4ZIOliwmiO2KaJrSOGr6/gKQ96L5dc5
	AmZcsuSpdwVB81X0FNk+q8KXCPvmxp18=
X-Google-Smtp-Source: AGHT+IE0eFPESw33JfWkreHkpBmuXVgMQWpYruE4CtoQxvuEgukCXd5q+5EAuID/wRomZNlf7jXpJVGQwrxqMyn7stw=
X-Received: by 2002:a50:8e51:0:b0:5cf:968d:f807 with SMTP id
 4fb4d7f45d1cf-5cfa069dcddmr30a12.6.1731684257447; Fri, 15 Nov 2024 07:24:17
 -0800 (PST)
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
References: <20241115044303.50877-1-brendanhiggins@google.com> <ZzcPJ9sweqxLZOGf@ninjato>
In-Reply-To: <ZzcPJ9sweqxLZOGf@ninjato>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 15 Nov 2024 10:24:05 -0500
Message-ID: <CAFd5g47+y0JH4StoKRTwJTQ2TsUCqmjdxqg=3cxY64Kous73=w@mail.gmail.com>
Subject: Re: [RFC v1] MAINTAINERS: transfer i2c-aspeed maintainership from
 Brendan to Ryan
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Brendan Higgins <brendanhiggins@google.com>, tommy_huang@aspeedtech.com, 
	benh@kernel.crashing.org, joel@jms.id.au, andi.shyti@kernel.org, 
	andrew@codeconstruct.com.au, wsa@kernel.org, ryan_chen@aspeedtech.com, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	BMC-SW@aspeedtech.com, brendan.higgins@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:06=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Fri, Nov 15, 2024 at 04:43:03AM +0000, Brendan Higgins wrote:
> > Remove Brendan Higgins <brendanhiggins@google.com> from i2c-aspeed entr=
y
> > and replace with Ryan Chen <ryan_chen@aspeedtech.com>.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > I am leaving Google and am going through and cleaning up my @google.com
>
> Thanks for your work on this driver.
>
> > address in the relevant places. I was just going to remove myself from
> > the ASPEED I2C DRIVER since I haven't been paying attention to it, but
> > then I saw Ryan is adding a file for the I2C functions on 2600, which
> > made my think: Should I replace myself with Ryan as the maintainer?
> >
> > I see that I am the only person actually listed as the maintainer at th=
e
> > moment, and I don't want to leave this in an unmaintained state. What
> > does everyone think? Are we cool with Ryan as the new maintainer?
>
> I am fine, depends on Ryan as far as I am concerned.

One thing I forgot to note in my previous email: today - Friday,
November 15th is my last day at Google, so after today I won't have
access to this account. If future replies or patch updates are needed,
they will come from my brendan.higgins@linux.dev account.

