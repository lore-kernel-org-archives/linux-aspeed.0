Return-Path: <linux-aspeed+bounces-5139-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8BCA5FF0
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz2hb1knkz2yf9;
	Tue, 06 Oct 2026 02:03:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791212623;
	cv=pass; b=n96bdduGW29QFLk0xMpJFWSqKb4b3i9V8WTpviyIYpEtLW36RtfoHmPlh++JF4EhpqcUMcUntqCMNzMo2uanBq9/GQA4ML3cd5MZkpqHBy8H5ZDyTnsbbtevJVjdnoP3uhB94o4ADloullRo+WWOPDzWOGUqj7DyQM2kLXB2BNr3fSJlqRv53giRVh4J1+84IR77a8/kgkV8YPKIDbP1EqhoUWgkSmzKzLtG0l2vMGwm5Gf3CPmiB82DS0MWWdGu/zXRofyjdXvLGZnBicw/S2kUbOyxkf/UeEvgYt3d2zVWeRWCi67oN5IFoi65/e/wWh4TY4NMBIeICaqSpieE4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791212623; c=relaxed/relaxed;
	bh=kABzR26FUddzoC8F3veFCKtMWyeoXM1NVTRtaYeniwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYKD5S2b84Va7kr6AvAemyInijat3RtV8Rc6yTL59OBQezyBucXoxP5T2Ziu59nmE34No47e6CbVQhZtngLYPZSJ1L+jhZ/S0cpeVUha8fhGrSO7rLIbW5boNTPL48UlNwiCVVwVcWiqHHHqycB7G2wSiGE+864CQITDQtSRkEiyJ0igaMnewGdbu7vYlCBL0T19OT+WvWnhnncGrAK8/B4BFdcZg2diUVYIyONXlHCkPH7ywH3y0sAtudGUVjB8+JGSTstNng/nyQWJcWiIj3JLhgim5Tr6cZZ0J5h/s2Ycr/ZFUkaDniNUb03draZq2+wQ7XE+CvpHI39wrdJQqQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQCtl5dO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fQCtl5dO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com [IPv6:2607:f8b0:4864:41::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz2hZ1L6fz2y7Y
	for <linux-aspeed@lists.ozlabs.org>; Tue, 06 Oct 2026 02:03:41 +1100 (AEDT)
Received: by mail-yx2-x2b.google.com with SMTP id 00721157ae682-8accbaa1c11so12006227b3.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 08:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212619; cv=none;
        d=google.com; s=arc-20260327;
        b=ZHfRmC+h+qmp1Sz3Eq37IDvX8DBjgK5LBJt8OqMssKSPOt3sX4VqCYqp7S3uwDBT/Z
         nSV6905hujwBxRtGLwfoYpaSpjmJ8QoOijiXmvNluRuvhvy9DZBnsR2gdlJxEih8mrVU
         UQu8ZkMcLXHZcjb23wuVoV89SClLXdc/xGkCXExr1AKdWqPMjuAntUrOqAkmYcekVtww
         Z/q4+xcOTxGAkSaOhp2L+AWhpkd/7eYcJCg39+6Lm5n0ASkcb0HJd1aDRiKgOD3NSWv2
         iuoWJ+IlC5mlCPGvv2IgeSY7dhw/ZALb+ET8TbroUt5VfJlpOv4lNsJPIE3lUWfbUmNQ
         6FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kABzR26FUddzoC8F3veFCKtMWyeoXM1NVTRtaYeniwY=;
        fh=o9nZs0Z1COUk/j+mLAiuqEzFKkQFCL3sq7Nnqt0Ice0=;
        b=c99nTBdd3sfuif2dbuCoC2+Ou0FWd28ILIJSgxzvCIzc62zz1bo3Y8CMbzss3rN8bO
         ZDU2Ljc2KWlHeS7dNSdpGKvgm5FR13eKOZvfl80jiRqsCDZlcjJMFuHH/HZkzj34Uhg0
         bUjySwqx8xug21Z2PlFhePUNABMGKEIDNPoiHi0Olp8BbaLlzS24ZKivI6gXy01YrajX
         nAiXYFxHziFNRLOu7dqAi0Cv1gBlQGnbA/aZs3+WGNV3eT5wv+eMHsm47BQounnXsiuy
         L7Cu9+j6X+daoxu5mK+SOLdCQOKmC3IKAb/MZIjJ6xdFfeO/7sEHv2yfbbVSPCRdzeOH
         yTqA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791212619; x=1791817419; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kABzR26FUddzoC8F3veFCKtMWyeoXM1NVTRtaYeniwY=;
        b=fQCtl5dO7AVLGU5YF/idZ1elXIW2MvXFZd6/kRn8nCxJXzBKuZbsPiabzv8uYY2Hm9
         FZeJIzBG5CtWWuWgKZFC1G61MxHNmQb1u+7zmdhbJlO2N8k6+Jd6Qfgt7g5IHt+SIxqm
         P4cZe9d/+yRBfckHMdkhGl0YTY3lpekeWK+lwbH7rDnyW4lT+EnBGPs1t4nP2wSm4Ixv
         KmkLFABGwbX/NI3OOYjCKs2WN3yEl/FtNNzz1oZoEoWmxxxQuVnrElgkqFtjh0C0sF79
         nuHpqnT/KlSee+1jOGaaFdmVvfjEKuw4eRD1Sdytrs/f4Urszsd2aABK5ZjAl2RGWdc0
         SdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212619; x=1791817419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kABzR26FUddzoC8F3veFCKtMWyeoXM1NVTRtaYeniwY=;
        b=rAZ2ScOM4dV7yK1mHCMR9BJ7L04bpQ8mQoliptkZE2Ij51SQvU+hwJzeQPX3wno/a8
         1uYUA311me4yux08OGh0gYJHMlBvIGZnvN1N2KMxmSJf4RV6hegIUvEeieI8pPvDJjaL
         f4YjfOT39l6Z2OCEt0OZ4sAtNuzsXnAhfVB1rm1FO5zpDJJgaKZ0VMtQiByt8Z9EtIU8
         OirgO66ECoPpm0ot5sZdzcy1XMwI1n0wlTy5fhfCxRcLgA2yu15jQv4FXE8pNNeJPr39
         jnbxKFXMEoZaSmR/I9B81pHCC/ekYJcD02IEBjhxdPHr2y5FDWg2uOC6ZwsJqEskRf1t
         w58w==
X-Forwarded-Encrypted: i=1; AKwUvBzXmdnmal7w2mZZ87t3rFcOFVwoj0kavfgXPYcTH13J3jo52+8aa8gHXqu+2b0jek1YJ3YPaQQXTQhRYSI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKcKx7GnivkrVyVykd+IFJN8KkP0r/Yn5p7mKgKtwzWww2Yvjbx
	hR9V9+nszkDomYc0GIyl94pN0CWT3/R2lcBo9ATmpLJEmeEmaUUkW0eBJIt4uAJieJGAmzyTu2S
	VzH6L771STd9InjSe4YBRp8Mdzd0qhDw=
X-Gm-Gg: AYBFou3WK0xObSNhvTjXZ8usQoGwyMkm1+zdV6U27o6sk6tHbnFvf3LUP+ltmYvBKDd
	ZNm2jinGKpiKSuHs+dlP1ZSkp5X2ih+YbsoJHiYvsqmY4PslAu6qmxAgWiQn1M/SbtIvseTRbX1
	heE2HzDVpUEC4KexCokZXQnnFjmRYUohXak+ZGqTTTQbRHZdaha00rikZMxXROIHn+7tZBgXyF5
	zoys11fmstclLdZD9ENS27PnKyZEDprAEPhFqRHSzDUQeB49vHvopcOaIX0doxvQeMKFKyfO+Su
	dl9l9qNy0kEGgbLTxiWrk8qClqfHpuoxDGfbLSqE1eQWaVgWGDOYR+aoXQ==
X-Received: by 2002:a05:690c:9988:b0:81f:64e8:cac5 with SMTP id
 00721157ae682-8ae3690bfd6mr39572787b3.7.1791212618431; Mon, 05 Oct 2026
 08:03:38 -0700 (PDT)
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
References: <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
 <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
In-Reply-To: <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 5 Oct 2026 20:33:26 +0530
X-Gm-Features: AclHuK_6E3giw7DMVtI3NjFHjcW3o3GAmqzSvLwH6NZdDb9tYMvxI8L2SsjXb4U
Message-ID: <CAMFFDGi-Zzwk33Rb2LPVOSz+XJa51iBQ3ZWEP6mLg4C362F=VQ@mail.gmail.com>
Subject: Re: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib ownership
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since THRU1 claims both pins and is mutually exclusive with GPIO
control, should the power-control consumer acquire GPIO122/123
normally and select a temporary pinctrl state that disables THRU1
before driving GPIO123, then restore THRU1 afterward?

On Mon, Oct 5, 2026 at 8:04=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.co=
m> wrote:
>
> Hi Prasanth,
>
> On the AST2600, the THRU1 pass-through and the GPIO123 output share
> the same path and are mutually exclusive, they cannot be active at
> the same time, so having the pass-through pair also controllable
> through gpiolib isn't achievable in hardware. This matches both your
> observations.
>
> Could you help us understand the use case? If the pass-through
> already handles the host power path, why is switching to GPIO control
> needed at all =E2=80=94 rather than simply keeping THRU1 enabled througho=
ut?
>
> Thanks

