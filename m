Return-Path: <linux-aspeed+bounces-859-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E8C19776
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Feb 2025 22:56:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z38wR45hTz3bkP;
	Thu, 27 Feb 2025 09:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::135"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740530904;
	cv=none; b=Wuyry/KPBxelKuIRBvrTd1bF88lv3NWi82vOgz4gENPMjFE389dsxHhXhAdyU/+sbGD6PloAOCnvDw05BAd3YLW0VJw+nuVe1YZkDeXmJekLXvuC0TKnt6P0GiZIEZaK+dCXwITjqBdjveoXsGf4kIGY72xTkxgUp7NSvP9aUrBsMI5XETNUlKfBvbgsr/EtoerGurf3gydvKnfZBLW+iAWagxPX8aZV2Dl9obHKCw5Cib9GfoEW3eBPdGIGP1cu+tebMZI973/axvMpUSRnpnKDG03YC8mzA6sU+CyxkHcwo0uZQo3yD8VwS4c8r/c5v+llScNTpO4u3YSSwEvACg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740530904; c=relaxed/relaxed;
	bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDuvgAVF/yTeNgmtGyctu5U5ZIwcKfd5EyGDe5a65LEW7skNqcUFQJPxiicPOlTdGWoxrLw1vMmJDojUAa7EJa0GnhDMvM5seB9cLbMkP8C+4ZBItB0CpGZ0wm0+IfHfdWeg9mWw79WWYaWGSJXm7+JjgfVMeq70LLDp4H6+aMAw7yLribvDLGcje7ozluSJJV/uTLRKkjC8BV/kjkq0noqopWyBQWJeLvmC1LxOAdBrKf/ipvuqhSEX02aUVbj+T274pCrMhRk0iW/+eKtYrapDjO6dh3oqbm1ZqWt8BF72tpLmQ8tYCwGOObca4sNFeVdUqvyvwb1gfj2cDzShBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=wULpqrsb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::135; helo=mail-il1-x135.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=wULpqrsb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::135; helo=mail-il1-x135.google.com; envelope-from=elbadrym@google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2bS72XjGz30HB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 11:48:22 +1100 (AEDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so55005ab.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740530900; x=1741135700; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
        b=wULpqrsbs28FwefmOsNNUFS7PqiTLA7fySwUkVbFfUtJ07aWzny9gIzmz10b0IvvZS
         NjM9WBh9R5JNpKCvouhEzD6+Ds4EdVVM9dQp2XdJ2zgS69CalUq1EQwr7RlOeKF2UyI6
         zaTbTC+0peRR5nlOgW1qGIGlIlfBtbYX0oR288PCcv/0o/i7rQCv28RU6hFcwQttnuWu
         mjcjB8lHc7zXgYCPjSJw6I0+90THqtIGekt9naGGj6nkhGv4/ZpA3kKdL00W/aQBS377
         hRNfZQb4kh7l6BbH+G1KB1mPCVGGN0ljrZKfEMzJkv7v4Bk+vIsYFfcT0ym6DUPsrJgi
         nxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530900; x=1741135700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
        b=S17RCLC1r0di4rBOLqe5GR+LOO7WF8Uz4ygfchwveodVySyAKQt4C1YQYoXPmDME81
         CnxHNmMUy2WCPBpRGp8P7FmIZPonNRn4R75uDUoyaJCafuXev23oq4+dCcXVs7BNu07y
         RB/G46ejzCGwemu8FemJOPlhGR2ZvAHdI65UTiPpZUUwE/iJxNSJCFBG1/9aLfX+aR1R
         a9AChuXWk+P8XMindU7UuiVwELeBhk/flqiVOJrlM/DKg50xgYvzA0c2Dt7vKNQEiRON
         R4F5LNaWujt/f6RyGyyS6/yywYLL0TEZyHV3/Q/1F4HWBswVQ7NDBtmOEab6YD/Q7uKG
         16RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqd3gVRjXo95UwIhgLgi29h/lRZ5JtsOJT8R9onq/o18moHi5bFGZ5lDk6DXeHnVfpiMSGTbmNqZb+49s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIdN9hsNBUU1Nks3xGoy2jrxBxxc52NvYSCUhChi8DsOtSW4Nk
	9rdkkq5zgVmgDlh/dHs57aYikjpDysh1tezY1vW24zbBAlr7A2lddwtD8bCN64Az+P0GDzKGp2/
	nXssuzH0n5MlozCdGrQ7y0S+Ur24worLfSeqP
X-Gm-Gg: ASbGncuYOlDa3b8YIZ4W9WsRUAmDk161kQfV8cEqTtUPfgVObv669r16SLobNQgMF8P
	CYVnXgmePqxDdPQxoGo3kdDIEu3l8PuLU7bNx2LVZu2EuXO+q1PxjbeKd9NO3t8iq7M/43G3Xim
	IPByFcz7YyOAOEjc1EpbmwzfxRXOQAPogIzSeECg==
X-Google-Smtp-Source: AGHT+IEonmoXFq+Ql657Kw6dLSY0rgGUEYIF0fLPMaaamVLsEFg6KhJOepe80hFReyd4EBHGAz+Lg9VVLfRxSPLAzbw=
X-Received: by 2002:a05:6e02:3dc4:b0:3d0:507f:38dd with SMTP id
 e9e14a558f8ab-3d3048be45fmr6716235ab.5.1740530900058; Tue, 25 Feb 2025
 16:48:20 -0800 (PST)
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
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
 <20250217114831.3225970-4-kevin_chen@aspeedtech.com> <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
 <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com> <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
In-Reply-To: <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
From: Mo Elbadry <elbadrym@google.com>
Date: Tue, 25 Feb 2025 16:48:09 -0800
X-Gm-Features: AQ5f1Jrgg80yi8orSiI63M_RmdhldZtwHc2ZYNn_1MdwWw5j1deSt788HIVdze8
Message-ID: <CAOO6b=s4CyVvCP8Gb_OGWCMX3ggs9sm6_WnqEB1h6ScVVJppDQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au" <joel@jms.id.au>, 
	Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomer.maimon" <tomer.maimon@nuvoton.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Jenmin Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Understood, your comments do make sense and are the right way to go.

I agree on not rushing, we want to see things moving forward but
properly as well.

Thank you for your help,
Mo



On Tue, Feb 25, 2025 at 3:28=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Mo,
>
> On Mon, 2025-02-24 at 20:34 -0800, Mo Elbadry wrote:
> > Hi Andrew,
> >
> > I agree that a small layer of abstraction is needed to provide common
> > chardev semantics to userspace. I think that effort can come where both
> > Nuvoton and Aspeed unify their design and agree on a common abstraction
> > layer.
> >
> > I think such efforts may take some time for both to unify, is it possib=
le
> > to get this upstreamed (after addressing all other comments) while both
> > parties work on an agreed unified abstraction layer?
> >
>
> Given Arnd doesn't want bespoke userspace interfaces in the SoC drivers
> this will need to go elsewhere, perhaps drivers/char or drivers/misc.
> Greg and Arnd maintain both, so the patch needs to make a convincing
> argument to them. For my part, my comments are just opinions based on
> my understanding of the use-cases and the SoCs involved, and the desire
> for reasonable devicetree and userspace interfaces.
>
> I don't think it's right to try to rush things as devicetree and
> userspace interfaces can be tricky to change or remove. Rushing tends
> to be painful for all involved in the long run.
>
> Cheers,
>
> Andrew

