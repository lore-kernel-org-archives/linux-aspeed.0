Return-Path: <linux-aspeed+bounces-713-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C55C021A0
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 22:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yv8Jv3BN9z30CN;
	Fri, 14 Feb 2025 09:01:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739410689;
	cv=none; b=M1G0Xwa+81NVA6dGumpDeLrrlYXMMK6CxMlCLPDSPZ/6l166Q7Oc4otp178LPyQYCQ8ICOzVm5UTL9ofsqba0ld8872/seKAGNfu8af51RUIRoBWKtUXUkvF4qII5IyHTmaTRIAV1cpgRjl6OO0mkuvoGehg0JIGfjtbQtg77anRDttNzVTQLJQcyJRfY9wGflWdqKhIC5HmUkkPfE5PDKWnLK6aXGL25NEOoSaNk8nMjpBmf1jByehxizzhtz2VRhrRy/80ac3n8M0Xny8iwF2YMjx4+PhHTxXf3pF/NhQckmy86m7D3eD+ctCVNrtZNNmmIW3LwHqMwmCLrKaxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739410689; c=relaxed/relaxed;
	bh=f3qnB+BjgvVqudxLGCEV8ahQDENtwWQvSoLgLc6HJ5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkcikrN67ue7T0OX7J8NyX1tTnnfU9zJVlzCV3PBJ8DFUcaEdvBnKvdqgk4bSQpd2GKut5VI2+oHbF5nWGNYZjVah/ldotJrWIYv8Np0DwvQ2/RK/SssykpF8Y8bNiM9ixaQZxBpughq7PxJwib6mb8NCiq3d2b7YTU97OH5MKSfYdI34weJSbzpwwkCl0URwgHdzMvE2Jn0SW80JwSKVIeijPh4OZx/U1po4W56KMNRQjM8K9OGTGmhHXnMxdd4XB5N0tarW1Ri/b4OTHWal3pcjjDijPEARUNOJmLmop58ypArIS8cXTnKOKUok9uPO8nfycyVUuRwVZtx2inbkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jCZJHUlR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jCZJHUlR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=chenyuan0y@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ytd9X24kPz2yK7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 12:38:07 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21f54143aeaso528825ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Feb 2025 17:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739410686; x=1740015486; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3qnB+BjgvVqudxLGCEV8ahQDENtwWQvSoLgLc6HJ5w=;
        b=jCZJHUlRs1NzvOgwqlSr7LGnhX4qAP4xIcS/yOobXcSrQyz8J1yFTATDHa/prRSCnE
         X6hcTOa4mcdNWjaikEidvKOOSnABxTv5d6gkFNpE1AdgJIWm0Hhxq/qKP/fE7A1qo6qO
         moKXJLb/MKJfGbU5WAkl2R/nUO8TUYK8IuZ+plPnh9Hkk21MuEeyjDMJEOdxlQdSCnFo
         3hhwdbSohseOduzqZa3X+TH4YWjlQrhqNTE+jXre9BqZNXYmYWAJbmdCrWCASOSwU8ml
         41pV8VDBRi5LwjnBQ/hJkRwl/NPMMe6DFZDuut/v2NN5wvGYaFRJMbC1O1OVdN/VBfNg
         DPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410686; x=1740015486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3qnB+BjgvVqudxLGCEV8ahQDENtwWQvSoLgLc6HJ5w=;
        b=MZS5ub7bbSbxgvg0EX1ptZmLofIkf4mqXcHckk7qGpB/AgX5yNXYnXS3x4rgASNlyS
         dB1/u3UZQvYRFHk5oR1Y2Lt+mKcshJtBQijOIKhl4XrU/PnVRqNc5g24SPcvUmpVNgfr
         NuqkV1NuOJvpDfQZwuAyxd8QNBXm9m7EkX4FmGQY+Ph+1m5t0qHQvcuisDWAbkYOZfOq
         5D82eiv1xraOY17sNewysJYFaBowBW7XdbIPuXfCAx2rFQL0f9dziALHqZ1WbEHrlEs2
         6zWGWpQs/F3Efen1cULnJsRq67SZ8vFGyuImx5rz0mXMP7paQ4XghdQldevphgoLJA84
         WN/g==
X-Forwarded-Encrypted: i=1; AJvYcCUpR0Ki7qXf3tBkQdMyFQjtXeb0//qt+HsHSbsU8P5m9CSrEwlzsE1ytFXATHnAMnhztvoXYDXze5puTPY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyf5XtFxt/ThtJhdcKbUPMEtOIxP3pMuHDwQkeT9UIdC6OUhOmH
	DI8qwznTO+bio2c6a+quyIe93IN6bc+cZho43O8zk8MHijXWPTbjhzg/xXQmC0QKhSsGmWb8Clr
	iWgpRmQPS9M2MEITDfY40KSniCg==
X-Gm-Gg: ASbGncsLjIzDv5OSSwIi6Eq7xg1BuA3/A25qouZHnR/uPdr7eJ2DUr5aTLKeprKBujC
	+k/mJZUR4/zA4PRWiKbbHL02HEp5t2RJtg60hnGQyqFTHNqmXK+s4OwUN/Xt6+VuJdFh4kSduJg
	==
X-Google-Smtp-Source: AGHT+IGNSf6rGtM/0ntuhaOil/OeR7IwjOWYFQDUAqkZMflXOFRT9qKkIxcKzWOWjZx79tkVLAIyz+1kIHTsJrDn3wI=
X-Received: by 2002:a17:903:2b0c:b0:216:32b6:cf0f with SMTP id
 d9443c01a7336-220bbb58176mr34931005ad.12.1739410685858; Wed, 12 Feb 2025
 17:38:05 -0800 (PST)
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
References: <20250212212556.2667-1-chenyuan0y@gmail.com> <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
In-Reply-To: <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 19:37:54 -0600
X-Gm-Features: AWEUYZnjQUUyxNUV0VBU760EACS8AzZdfQ6WtL9mWgDhcmj_152WjiAils2-6oI
Message-ID: <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your prompt reply!

On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Chenyuan,
>
> On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > a pointer check is added to prevent potential NULL pointer
> > dereference.
> > This is similar to the fix in commit 3027e7b15b02
> > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c").
> >
> > This issue is found by our static analysis tool.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 9ab5ba9cf1d6..376b3a910797 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > aspeed_lpc_snoop *lpc_snoop,
> >         lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MINOR;
> >         lpc_snoop->chan[channel].miscdev.name =3D
> >                 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME,
> > channel);
> > +       if (!lpc_snoop->chan[channel].miscdev.name)
> > +               return -ENOMEM;
>
> This introduces yet another place where the driver leaks resources in
> an error path (in this case, the channel kfifo). The misc device also
> gets leaked later on. It would be nice to address those first so that
> handling this error can take the appropriate cleanup path.
>
> Andrew

It seems that the `aspeed_lpc_enable_snoop()` function originally does
not have a cleanup path. For example, if `misc_register` fails, the
function directly returns rc without performing any cleanup.
Similarly, when the `channel` has its default value, the function
simply returns -EINVAL.

Given this, I am wondering whether it would be a good idea to
introduce a cleanup path. If so, should we ensure cleanup for all
possible exit points?

Looking forward to your thoughts.

-Chenyuan

