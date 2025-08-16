Return-Path: <linux-aspeed+bounces-1987-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB5FCA0ED1
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 00:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3fcL0KTLz3cl3;
	Sat, 16 Aug 2025 10:14:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755303282;
	cv=none; b=c/XiJUbHE8A737R6kWcWStRvYHJI/fmlUv9nuaQXpaPqf0WGT0ALPHZuOfVOsQbMo6B+GvJUzjIjmcuLINQVWnOcxaZe602T0DhBGK87zWeznUVMe6YDPCfK9tAd2b4Nppizphtus6Uifpn/vr8ZeKKvN1F/ToY3d9DwCwth+2EuEhYrjorePR3IfjCwaCaG5v4C6wnlgGW1vL+sVjZHf8mYtW0wxOLLf8ji90RJ+IWyBfqGTp5k7R1oK149RIsHOPhsRrd+GBEZ/iCc3BZ1WNR/39NsAwEB8SRwPTsyI/apPf08EY8nBr5TfOPSucYykx1CfrEwlwfGmFji3y/uyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755303282; c=relaxed/relaxed;
	bh=zKgVNPs3coZu+nlo6fuf/gzn/7j5KTveQsRV2Eq0+aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLFRj/u1YUbfhLL5Id0YhdJfIVGQ5Ai9SupHfURhatvLajVcWAX83sTu9Kb2I37O9XhkWeD2BzTtNLLTd3VYo/UYtKo1lAWXCpNdPQuxcekT0c8jaHmdqmkck3OcmumyKXzmP9TfmXbizgUIDb9aqO8fE8JiwWWP1cy276CL/XmrOsTX3B1uuIk7Eos3uleNKOQf45JgxxKWBIV0ATNaAHrkGFt/WGPB/Vw4hah/TLGfmdYD2pHiGgRIeUWz3QgfujQrGXSUBCT1j7z84T07QJX3ljQmrVcrj2rTHkLYspjk2Q7ypzjmVeeUHV6U74DIM7kp9abPNo2pZQit3Zm2Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BN1lpdWF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BN1lpdWF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3fcK3tY5z3ckc
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 10:14:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E22D45317
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 00:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE03C4CEF4
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755303279;
	bh=iHEoGce0lrAJlVMlHROATYg+2I1Mlm8VsTj1ni7pM3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BN1lpdWFMrtOFXBfxNdIq2waQC9pjf4+uT4k8HKft0iPxKdzyvfEQuqk+mts6O+DE
	 Ge+g+WGLUzNtceZslkSk3ep+CVuvqwXA3L1dAsyIhfF/Q4UPFvG1crxqlE7nePnDIe
	 HfchDENsn1HgspLrThZGcg2tOAac4DmjWkolu+xZ5CNgqva6RzhJAdkGwBeNqDJcIH
	 o4R1q4YEimYxmjq1Qa8U9XP+S2/MxjyUEsYi7Wsez1BpaY6eZeFKWWzY+5VusZuIwf
	 K+eSN7sD/yBrimFP/mY43sMTglKnkUgkc5Kr0OwAQSnxqVEQGKNH28P0+5y3eGAFlq
	 IoGfs94jcJOFg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso433076466b.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Aug 2025 17:14:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyNAo0xR9RnBWvH35ZUT+kMUuh2Jioee7VR6s8M3tv2374TU4Fm
	9VQxTH0K6bWYpJdQChJ4dB+YPDE4DnU2Sd4guKgAkBBCrBWH42S3Vk87jfJZ9riE3sZpJfDqkWc
	g5mULcZ9JpJYmnbRokCOvQgLmRvrGpQ==
X-Google-Smtp-Source: AGHT+IG2VIiAuWG17o6/htgWCGniyJwLypaOw904GL2sgMLWgoBf1WnYJpROqJLvjaEdcULRveOwlH2p9ViPonEUdDs=
X-Received: by 2002:a17:907:9410:b0:af9:5993:65ed with SMTP id
 a640c23a62f3a-afceacaa2a4mr75600466b.6.1755303278104; Fri, 15 Aug 2025
 17:14:38 -0700 (PDT)
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
References: <20250815194730.41695-1-eajames@linux.ibm.com> <20250815194730.41695-2-eajames@linux.ibm.com>
In-Reply-To: <20250815194730.41695-2-eajames@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Aug 2025 19:14:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKg0r6By9nns0vp=p2yc4C_SN5D7X_7vHzO8YvrMVoPTw@mail.gmail.com>
X-Gm-Features: Ac12FXzEw5UY_40A9C58CjFUarT0RRHoHOqh0PQOwJ_a7D9_sswOpSt2S57unE8
Message-ID: <CAL_JsqKg0r6By9nns0vp=p2yc4C_SN5D7X_7vHzO8YvrMVoPTw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: aspeed: add IBM Balcones board
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
	andrew@codeconstruct.com.au, conor+dt@kernel.org, krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:47=E2=80=AFPM Eddie James <eajames@linux.ibm.com>=
 wrote:
>
> Document a new AST2600 BMC board for IBM P11 server.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

