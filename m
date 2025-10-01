Return-Path: <linux-aspeed+bounces-2378-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A76CCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 22:38:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccVF76rF4z301G;
	Thu,  2 Oct 2025 08:38:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759308869;
	cv=none; b=H0KWGPNCZJbh2i5q8Pn+PCizOffqpZXp63y8gLrS07ePeyzfVcVlzTdw6sPgQuhdF8RFmJ0IL5Hlnt1Tu7MsDYNpBIGy/fGGE8drrTuBWcQmQT3BMQo523Q3AnLnJqOWZamjpX1uC3ipXKOPfRX4yisu4ScBV6JvnfvorqttXLiZparfFGCVdPHdyyrfbXO1C1/R8zieoY3DCRWWOtkzOLDVs+wn3zQzPEedrtColt76AGk+oGz+r84K/tMR5Zq58tcNJA05cn/iJ/9V4WEIWbuexc+kRYvRHZYdSDVbFGX4+ilr86EzH4PB4VA/Trzyv2FImmzX+SwRijysRV6mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759308869; c=relaxed/relaxed;
	bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMhHhO3LwiizV1i4mBvwALM3xgmXfTouLtneng1MnIJl+J+zO7NXf4lR01aDXnxGrY0nVIdVkS23Df8iKIqxgsj5C1Zena+aft4P94K65w58FnCLvBUzV58UtUXX+a+tD2Tg6yylC9yrZr8KtexIPfgwdjDdn8lDsSPB4BNrPmVP8PQQM/nqQlSu6lEK2Iqyi2x8vCDgjMH8BeW4sqeNMu1F1ei07T6vPONPlTA9b9/q6Vue79/DdzdEUg1toGkgVyeboHaG4z+9BBKuW8Br0BODIqUXKHoAuNWwQklkiOKlhJueUApmLbIDOtrANjXK0HvMUlPGyF2VEfgyBOdDvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OuhyEOgR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OuhyEOgR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cc7yr2ZC6z303X
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 18:54:27 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so7865824a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308866; x=1759913666; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
        b=OuhyEOgRX9WLFFdMcDvloWjnRqvvtvaLcH8SAcZLo61ov4MDY64DmAQAdkp3pSZLu0
         LrNgVc8rmVUf5ykL6/ClkbT526QrLV6ucJj4tTJhS0J8ZMUoTrzlLMCCKrTOoHR0bLEN
         T68g7jiHlhvmrPd2KrKU8rcFuZR7LBNjRfTxO8D48UjNyKbeczMMLsr7Smi6AJEN0H2U
         SRa0ZKx8Aw0Mism+bw3nOiE/GG4VwA+CygUYHhm6jmTn9GID1cfQV0goFoHJOF2jAWHn
         zZJsZ7k4jQBfxNOlRttvXoQ5A44TIbIonElx2JP5d4CCKdh2Y/5VpNm7v6KIuZvpYFKD
         bBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308866; x=1759913666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLy1r4an6UfTJPaHkyT9U6fPTve0eRlEi9oZ3JIBjEQ=;
        b=vC19Qn/btI7JhYeML1YqsD06W99isir+e2B2Gt/RPbECVm0u4K+ci4s64qGWqOA92v
         B4WgYhC5yGv+LFZjJuk38VgSHtom4rOvJIQuyqKd/i8EfZwQYa3ys8+wv21llJyGcV/t
         A4kXzuN0HBFBkqsLFgTEFnvoxA+9V1Mg586UdQSqMtwIRBXSF8TluqVzS1HxnzdYpSJL
         HtgeL2LJfV1izW/LiL++tsYQdak4iX20eGebcd+OUbk9U2JsqEQWq6W3QO+70kpuJtTo
         b86plg3zukFh5YHscFLI08CHpYBn+tFw1kGfVs9MIO7J6/djCvNbYUHBYV/fMBKZBrcV
         2K+A==
X-Forwarded-Encrypted: i=1; AJvYcCV3U6oqaREH8a4TCdkLbljHpfIir2/aosIjbLied2zI4zk6tiC0voce6RUYUHghSFtBJxAoQoioCnqT0lY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0AcrAArlmx3ch1cgzDv0g0pJ56JSoljCM3gw00IoUoSuLatx/
	h+ShhBn8guqWM1LLZxXtKmmtbFUrFiNzzY8TRw0j8aPF2x+at2pBQbNz4zQZujiqzIh7Uxvuk2A
	LxjmK9iusG+c+YXdRkNJNAP5qk5/rung=
X-Gm-Gg: ASbGncvuR51x+2BrVwano0soRH6dx+hzs2TZDDgdkFMpAJyJnAloAtTpKdAz6Zd2OTJ
	C0izcp59kFbS9Zoz7GPz//Khtp+6hvVKYmgQtwkAup9KlzGgtw9pKRTCjiurS+8SBSOjjhSGvUS
	k4XuSJLSDpVGgui4rK0MZT6fn2Q1zSmAO4Q4RfIR1wTEXyIjO58afO+cIONED0qVlhFZzZoz+n5
	0JdpJYWhv7IyLUznUaS3IyXhnURqphLF/ngauYZ0fDXJAss/luFN9SqD7iT/iUoGw==
X-Google-Smtp-Source: AGHT+IFkHVvzIlBnrVeHVBtBctgazh/MCfsQv0mLNCnxfXKJW1PT7QAVMcEH+xX6FJvFAD4mRgwQJtqqKlzNOAz6QnA=
X-Received: by 2002:a17:90b:4d0a:b0:330:84dc:d11b with SMTP id
 98e67ed59e1d1-339a6f36367mr2940411a91.18.1759308865859; Wed, 01 Oct 2025
 01:54:25 -0700 (PDT)
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
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch> <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
 <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
 <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com> <090d0e196fd0f814b5385f2c6e47e5196f0be649.camel@codeconstruct.com.au>
In-Reply-To: <090d0e196fd0f814b5385f2c6e47e5196f0be649.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 1 Oct 2025 16:54:14 +0800
X-Gm-Features: AS18NWDyzaFR3D4tmBrIV6Dx9lyGm72vUyiAB7CZStN-eawEDelhMt9miv_jN1k
Message-ID: <CABh9gBcaUbwR9ScT_xSYo3q6FHZaMyXYewByPQoReUp1pktcEQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:16=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Wed, 2025-09-24 at 08:34 -0500, Rob Herring wrote:
> > On Wed, Sep 24, 2025 at 8:05=E2=80=AFAM Kevin Tung <kevin.tung.openbmc@=
gmail.com> wrote:
> > > I also checked the work with `make CHECK_DTBS=3Dy
> > > aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
> > > and the warnings that appear are not related to these patches.
> >
> > Um, they are related because they are warnings for *your* platform.
> > You don't care that there are warnings for your platform?
>
> Which is to say, by contributing a DTS that relies on the ASPEED DTSIs
> you're now part of the community of people interested in maintaining
> support for ASPEED SoCs in the kernel, and it will be appreciated if
> you could help improve what we have.
>
> If you could pick a warning or two from the DTSIs and contribute
> changes to address them that'd be great, as this improves the situation
> for everyone.
>
> Andrew

Sure, I will look into contributing a patch to address some ASPEED
DTSI warnings and improve the overall situation.

