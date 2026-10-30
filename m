Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E33606A337
	for <linux-aspeed@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VHoAeFpH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGLlc5pp5z2yFQ;
	Fri, 30 Oct 2026 23:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e36" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793365164;
	cv=pass; b=DvpdTYKcVhrQwHja6mYoGDgvBILh4VNAO8ldPZwdD00QbnJWt/GNPAUR0MqbPzDnWEf5NA998KziGnPEM+EZOiz3QTBURncB7lnUMxKsw/yc3PQlJ9Co6OpDqJQH5wtxDgThU7BjFjIH/joAOMwVr1VUbxt6kMrEwMdP11k6miNFxA3xI13mLj6xL9TFdyIN8e0Yk8hQlz/DoZBXddOu+RPZu7HYe7HmKxvC18bGF/DeVPVFqPNJntnvQOfVLZUWmBOla5kTv7J+forHOQ8GT7vf2Yfqv5RUYRdK2w9xGitmvS8tlukrg4LC66hEoI2JCusNtCeI9BciUKZ8aKIwPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793365164; c=relaxed/relaxed;
	bh=3YyLSa3BTi1tUsUm+bl9FSELrR+28ROQxS5lQk/+if0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1UpvbSva9wjiAaL4Z3OMZ4nrpYouoMbxyYQEwFLNfAEIRwHVGW5IiptXFcRtoOiwZb1Mzr9OyaLvCeQCOf6qds5YKICtsUXGFIRrO7f71KPFC9Tqn4g2y/2IC+MjFrIGV+fR4DpS9jNZlDoMYWtwaMs73mIzal3ZiWvgZW4PMSAbIenRRfaEdvFJOK6yklPlpXseBV9FbRnCWKhPqe3MopvMhTXAZPZfiaMGyAajYkWOM/ixQxDu31PFnTS/aebmOvVa2AgGHZ+wkmY/BVWvIrVWNEYkM+l6jL3rlE9TnnNiYGvTo15CPirS0+FLXg4hbaf1ySsrKjxQcsPwfh7ng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VHoAeFpH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VHoAeFpH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGLlZ3t7yz2xln
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 23:59:22 +1100 (AEDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-7d06763335aso199579137.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 05:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793365159; cv=none;
        d=google.com; s=arc-20260327;
        b=J4PMQIWE58ZXcC2WOTysrMzkPONHqCQdSx9i3B7MPuFuJXuQyx/3L9X8tN1FLA6pic
         urqqc7gFrdZrbH4n5YInz5lwqSERPwKRZwf3AfWqFz9GlnjIq2meIq0bvO5Aev89WFMe
         u3bvv2lFbGCWSEpzgkflhoaSnYaAt3Cb6+b6tM7T70SAw/N7hxeKIleRfrZx7zTSpW88
         V/PXy8qfnaW8w2TS8p+bXoCoWMf/jTXie8bxXVKLoehkdxHUMMoKb73QgXk7VUZBD02w
         RDdpZPkjY2p9pI8sV62+WtSgwxPEdhMHnKf5JEnKbViCJXJyNw2SiPJ8GAbfZdL6oEEr
         BtAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3YyLSa3BTi1tUsUm+bl9FSELrR+28ROQxS5lQk/+if0=;
        fh=e8ct5DEHaelGIkmUASy1M4VTJaBVJxh71bffRe6NMqA=;
        b=apL6UTE3ObOtxxkePoc0QrVWpPVuRcgVRoO0iqYg9KHsiXL04Jd2RQNI5gUYGy/2VE
         MjGbbc5/fRqfCX12wzP4Hcjke/ZcwIFci4j7cG9ioHbgoXhn+y67RcZDqnmXktdEp7Tl
         gzONjKlVtmr7/2+pXlTl/yMF601BfhTxEuzp9sDt2II7vjR1oVInl8ETyZhoZhf6sAWO
         b9ueo75KcptLfqWQ2DLTm/U/qCTkya2wW48iKO0qcxRYjVgSPB6UROsDVmFneKB/mu46
         TDdPfPuoOYwwFMsuUaaOfgwNg/IcGReR0vdW014NcReHv24PcBo0KFuMOcwP0qn9eNMk
         bkFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793365159; x=1793969959; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3YyLSa3BTi1tUsUm+bl9FSELrR+28ROQxS5lQk/+if0=;
        b=VHoAeFpHicRNfxdTK4HWme33lnnTvqKGHh7rmuaiF+igf8kS0ILNYPyvNNmYhWmBQ8
         yPT5Ndo+j9tqn06jet/pmw4yh5HQnHHDd7p745phgYxGITS8yZgs26Mes5ZAPdxanoeV
         ke86g8fdTwk4iNPQ6/8G6fD0PE9tgbe78UM2m742TMr9EN2affECJBX10zjomu7PJ/mF
         MUfTAocTBOaucKLKOMQAvClLzE5SWrIX320CbTeqqCGWXWpbS8QkoOKGwn8N7YSbBME6
         46Fn7PqmMwxYncpEz8VdPeLTMKNw+GPTm9I21/wNhQRjr91wLr1YHWpRF4WbuS9UGQ20
         u3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365159; x=1793969959;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YyLSa3BTi1tUsUm+bl9FSELrR+28ROQxS5lQk/+if0=;
        b=nqBniz3s/NXvLFuCcfBekJLqwGFv+6PLERVOgwj2VvrrwAirBAXTdj9egknLDEude/
         Eqpjkja1Z/+wH5CaP0FeJ4bJVho1kmvaJSVq3pcTMGZ6hD7eEo8kp1fYK5iHgSUAv4zG
         Us1NdYuEGeiCbPGHd4CGkqrG8iVIyzNIZ2kJdUYUwSdH2GOdzmevjmtULDHVp4pvmCee
         HPy9zdNQLIlJSYR0Ku6NrkJKxxDw9Ask/4hqMxiudZ3GiVMmJe60vitTkGc+VPzF78Vk
         l00iP+vwKZ41Yg9BP9KxIseXxQawy1/qT/usF7ZZ2OZFW0617lBW7OqxwtMwa9jlLb97
         ivWw==
X-Forwarded-Encrypted: i=1; AKwUvBx6FVQUZnrJ4aRFGBn4N+isZaXw4EHZlGeXuG8DpJersamGHiZ629XD/4uGg99ekFDLFD9aeZ7RGm9zyXI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL9dqJ+lkRwqyyFH8cHn6vzKfWUNABptaYESvBzDjRKyY6XonpC
	5Ymqypf2qae8DJ0D+S0XndjbQi31wen8SGU8Iv0Bf86Hkdae+4ELFksYAkkF3VOd0RzeXqztxwP
	oEWFtZVdOd9vNvS1Bg1QQIH+LkXu257I=
X-Gm-Gg: AYBFou2ww+qJdnurGv+HPur2AhAGNkqP8ahxGva8DTCin5eGRmtiik1mFfQKDg+dpl8
	+eORFgagBptMNcWTLTBCygyADwyZijwx3GCgjC1jZxfAZAh9ANKq7vKITTGNVMpXU+D8RLG+JaK
	3uzmG8e9YKB99/uZD5R06CUZkyWJNZ6fjoSXC4RE/1u0jGQWXfDHtcP1PjtPaLgOAa6je5JZ7nN
	H/Fffp4DlCEXpKhFotvH2shvQDfqv90DbmLk4cx4PCcHFgP3SCWb7gsZipJX8zpMW3RIC8oyqMf
	DCeTd+i7j4vQAvb2uMlooR4fLzpc1ThfKRHoYw35ZDq9MiPoGRpYdrit/G3MU1Om3NmNrLmT3ib
	DBe9cFrYTsiyxOe54X2KFhw7Cj8gvneRBTfwxnhHLlAcEp5qa7mSS4h3KKoNte3GT7lR624Y=
X-Received: by 2002:a05:6102:950:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d072bb3726mr982684137.13.1793365158793; Fri, 30 Oct 2026
 05:59:18 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
 <20261029-anacapa-devlop-phase-devicetree-v10-5-26ee3cf9d9d0@gmail.com>
 <c78efbed-e91b-484c-b2a8-4e44383bbc30@kernel.org> <CAPBH0A96nFFqv4a0--OD=67w=uNkiX5qWb1aQFF9=kGVsUijRQ@mail.gmail.com>
 <79b1da71-7a17-4d75-aa79-ac1a18303b2d@kernel.org>
In-Reply-To: <79b1da71-7a17-4d75-aa79-ac1a18303b2d@kernel.org>
From: Colin Huang <u8813345@gmail.com>
Date: Fri, 30 Oct 2026 20:59:06 +0800
X-Gm-Features: AclHuK936QikowfoO5i5BgELLDpuDAgVgr57QkGt26vDuZG48EvAF5wkFnKQPU0
Message-ID: <CAPBH0A8YCzNBKETf=mm08EggTDiimd0vDXK9V+vfvGNzENfcdA@mail.gmail.com>
Subject: Re: [PATCH v10 05/16] ARM: dts: aspeed: anacapa: Add eeprom device
 node for NFC adaptor board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com, 
	Carl Lee <carl.lee@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=8830=
=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 30/10/2026 09:41, Colin Huang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=
=8829=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:43=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> On 29/10/2026 14:38, Colin Huang wrote:
> >>> From: Carl Lee <carl.lee@amd.com>
> >>>
> >>> Add eeprom device node for NFC adaptor board FRU.
> >>>
> >>> Signed-off-by: Carl Lee <carl.lee@amd.com>
> >>
> >> DCO mismatch / missing SoB. Please read submitting patches document fo=
r
> >> further explanation.
> >>
> >
> > https://github.com/torvalds/linux/blob/master/Documentation/process/sub=
mitting-patches.rst#sign-your-work---the-developers-certificate-of-origin
> >
> > Thanks. Krzysztof
> > This means I need to add my Signed-off-by to each patch, right ?
> >
>
> I am sorry, which part of submitting patches, which tells you what is
> necessary before you submit patch, is unclear? Please go through all the
> steps of submitting patches and analyze if it applies or not.
>
Hi Krzysztof,

Sorry for the noise, and thanks for the pointer.

I re-read submitting-patches.rst. You are right: several patches in
this series were authored by other colleagues and I am the submitter,
so my Signed-off-by must be appended last in the chain of custody.
I missed that in v10.

For v11 I have:
- Added my Signed-off-by to all patches authored by others
  (Carl Lee, Rex Fu, Peter Shen, Andy Chung).
- Fixed typos in two commit messages.
- Re-checked the series with checkpatch.pl --strict.

I'll double-check the series for anything else I may have missed
before sending v11.

Best regards,
Colin Huang

