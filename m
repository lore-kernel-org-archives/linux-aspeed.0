Return-Path: <linux-aspeed+bounces-1986-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F8CA0ED1
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 00:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3fbf2lbpz3cl3;
	Sat, 16 Aug 2025 10:14:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755303246;
	cv=none; b=UHBZrFq2RfshKTXWS8/jz0Ou4+JF9qkSrDogYYMLlQewr7elbQe2tD/qwY8FmcA5eu+JtdcHhNuWp8ZSLpbN9LO/kMRJfIsvoTvHlmEJVPB1jkLXDOlrXWNjrHxCD20qzTb9zgKBSYt/XYgn3Atx+75AFMkaRT9kVI4e1y+u4M3Gd8RY2YKRXOGXrpHiVK3n5otGvaH3sUfm/DbEVbcK4qQ/dcT8Rvr5ladyuAqH9L1AdOZmDRSfWE/7egfX7MPe9oWTw7TQURbfrPHb/fnoctUjoUlh5UEV5yDsG780xH7xT9qdE9hIdkB2+C91kXbhMWQsAcAi4/MUoZjzmZQWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755303246; c=relaxed/relaxed;
	bh=ewa52bRnnKbFMWSf3qe4pgleSAJA0Ex0CKGHu494dGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFsIXJn3LmC/qUUKh1nu2El2lBkwCzeh/imvxm0RapFBXscd8G/BNJVCbHWlWkZEHfSfnYPZE3GaK9sySastU23Jqc12So2B59IWuCbEAH1QPYjsDCeyHUX6nZ0YCceUTqU25AplfYzQfckASibodRZEbgZgf1MgBPOWDPPgE6mbGmv3s4J74gK145LtK9P3V0iCFx+UHYiN4t6FcMzYSb0jLOiwSFsAU3VsTqJ0ElpXwjEuTBm7I1iUE+yMOUvzyRKDe9Q7b9lDNtqw9W7FhE8JxtjBh8riTd6Tv/Nm09HVz+rR5B+Xt45WEhtcbX40Qj2ew002TMrdcrdWv13yCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lmnz0MXc; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lmnz0MXc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3fbd664Tz3ckc
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 10:14:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AEAD55C0696
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 00:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD9C4CEF6
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 00:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755303242;
	bh=fLaqf2awrJNL9uv9xCxXAVCx/3iMt9F+InNgK5ZkY4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lmnz0MXcjYLVTi1mqtWpU+U59wED9ZDSrgEmzV9FQ2Qj/EzaEiHnozG0LwW5aniEn
	 5U1LV4o1NOe94Mv88CtCSVrGrCBa5H2ta5ATdyol6kC4nKW8LMQFoNFgMbHhTMa9ow
	 vdwdiP7z2KFJFuvPVNdBSfTgBjX99lMLdjw8Nl5+haHe/cJGekvNKi4qyZhpo5y4l0
	 qB4ttumfk1h4V0nK8I2IkRb07TDbv8+ZIDwc91Eh/Q1mc/TChOsGFt+qEGby/mg4lM
	 WHM2QqTWmBtTfL99J3Qr3cboqLT1y/QWXWHoHwGjWO2DhYk4eaBYOE/8lII8DXUbvX
	 3rmrexbXYQojQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b690517so3667364a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Aug 2025 17:14:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQPkIL5Kp6nqygPuI7msTMLpCd/VzNRAH6sxZF7QA+LvbdIxHW
	Lcno/OpLNkn4d8Ywq2g79MkxlUkezw4AnVH2xHnU/rbFxmy5+1eyx1eS+SlJ7o7mCpY0RypJuND
	GDrTg+epq5jZnTKdzAvxMQSRXBcSTqA==
X-Google-Smtp-Source: AGHT+IFyQPbQZOaRNZPy1bRsx/UfHbFPiVTd3Se30scn3530lmWaMeyfQuqEBQCdQEt95z1/kRLovyY9OGxd/oiGobs=
X-Received: by 2002:a05:6402:254c:b0:617:dc54:d808 with SMTP id
 4fb4d7f45d1cf-618b050d5d3mr3040909a12.3.1755303240679; Fri, 15 Aug 2025
 17:14:00 -0700 (PDT)
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
References: <20250815194730.41695-1-eajames@linux.ibm.com> <20250815194730.41695-4-eajames@linux.ibm.com>
In-Reply-To: <20250815194730.41695-4-eajames@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Aug 2025 19:13:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=b+Mp5M0OZn3U35u4Qy8ZqgitKa+tUro9q=7AeKqGiA@mail.gmail.com>
X-Gm-Features: Ac12FXw2j6IITcEbcT1NDGfV8vqnxKghPQchKnzgWDT5cIJSCqMfW5Ar_VQBokU
Message-ID: <CAL_Jsq+=b+Mp5M0OZn3U35u4Qy8ZqgitKa+tUro9q=7AeKqGiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: Move max31785 compatibles to
 max31790 document
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
	andrew@codeconstruct.com.au, conor+dt@kernel.org, krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:47=E2=80=AFPM Eddie James <eajames@linux.ibm.com>=
 wrote:
>
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
>  .../bindings/hwmon/maxim,max31790.yaml        |  6 ++++-
>  2 files changed, 5 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

