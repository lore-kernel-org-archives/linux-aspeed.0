Return-Path: <linux-aspeed+bounces-507-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91BEC02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 19:57:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYtvJ1Dbmz2yG9;
	Fri, 17 Jan 2025 06:57:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737057468;
	cv=none; b=kiNmPEyb+YQAVlt4i16OvzgzslSuTgSynNvgOXo4LZCpQXOh9QikCIdkK2PfE5BrpABISE16eEPuEkwq/ZNF+LT56tyQTBhAl3lEU1vnqpF9qwHfvg59+fdM7crPnX29ah2BLYdQtwfkVSZ2Y6CuZV+HI2/Dsr5hk+BgNcASarpBsvtyCnbSAnBeyPE5Zlo6BmA+GHR5GLNCFSV/+PtZ3C3W5ZYV8TElJsa2w631Tr+TCe+Vh0wATCo8p3R9NRJJcQLJ9XLW0vxn0ezZo11D/tnCKemqqh75Uq7TItD1J8WdcdAg+t/9X+TZ3YhGTGaEnvPL4elEVII1pgBEoPDn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737057468; c=relaxed/relaxed;
	bh=KX0PekS4oyZJN7vq29nBWyPFMEjESyyECU6yqKwIP9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjyPDiltqnBLtrGBPXC1wwKXxPFq8WEDfbHAOhjhjEvkuM9cjC1OtLlyGRlalb/nsXeATug3S4iH16dkh6TO5hcc39eeCJP+DK4o+Jea5iWK39en51oSPJuX0NQgJo1qvoG8SZbROkJGbmZUfyemXAtSQo1BwPfmljt7XrSuXw2sgxCTuOpYRtj7pk5VUi6GvGJ2Y4eoUoGG2vMUtJyqOhpUfnfmNnVE2s4Z+tBGPI+MtZKqHGiP+/kva/lz0HXavo4B3Ubg4meheZAvyE2aVzn2SU6uRFxajKYTUc3DekULuvol+8tr/WBBECdQzHZssq33HftzvjV84qWaPOgeQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aqj/PJ7J; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aqj/PJ7J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYtvH27qfz2y66
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 06:57:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6427F5C5DCD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 19:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D93C4CEDD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057464;
	bh=BpGbL4CFfsflMGaBvp4j9m1dN/ZGd8uGCM2kddow5H8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aqj/PJ7JlbWZi20JPqqhgl4FtKBowEHKrr5py0QJZaT/h7NwbJLKWtfZF5HVJ+f01
	 eaumhpfu06/SjCfeP4TGZg7LFj0jw5dpOxHBHmnfIZjWAOLq6Gictv0ymZ294BVo+6
	 wZxDS8gqUVXCZFkkiyPfGqx6r+MImWIilKWs1HvUPklZ8YaFqKl3Gk24rjgg7ys+D2
	 TpIs5/FNVV7ktyFEOULoBvnjU5NoveD+FaNRhRgWJYYvPlaC2gBzCYDaoTGt87wI8+
	 WcnzI/xvOoCtspwq+cwpNhM8PyQ0GWcAnShRPgNtAGka16GTj2unoDYSF7vH1jGFbW
	 mkYRd0WRyzITQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30219437e63so25872641fa.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 11:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaXr81Uo5G5zKHJHaUqZtMAiDJI9E30R5UA/icp+/Vy9W+56FWlw2ui6YFNS9hbf57HI1zK58KzDLxmNs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSea3Tl9aX/P0NmhClZ6UzHzkdIT4H7Y9cDiIu0Li2Oc6/w1UM
	hvbL4elXRp4COaMbAhYGHqIuZTeR6gP/6kUc7JOU7ffRR9nLRnB94TygsnmMRaah1lUKx4yxPrt
	IWpoaVC/0CZ+Mq4+Z5R3Kru32CA==
X-Google-Smtp-Source: AGHT+IE8PDn7axUoinBnTIfZ0cfMVPVQgH/bj9hTJDusIxJXQXf3Z2wDnrh+6FvWe+I1CQJPWkBXl12skSmq8p7UwQ8=
X-Received: by 2002:ac2:4e16:0:b0:540:2fe6:6a3c with SMTP id
 2adb3069b0e04-542abe955e7mr3496186e87.0.1737057463177; Thu, 16 Jan 2025
 11:57:43 -0800 (PST)
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
References: <20250114220147.757075-1-ninad@linux.ibm.com> <20250114220147.757075-4-ninad@linux.ibm.com>
 <173689907575.1972841.5521973699547085746.robh@kernel.org> <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
In-Reply-To: <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Jan 2025 13:57:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
X-Gm-Features: AbW1kvaz7cz0JErISAQO978pEbpoqDGvU0yV8aV8M5Xy632yu2go8X9lmt54eW8
Message-ID: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, 
	linux-arm-kernel@lists.infradead.org, edumazet@google.com, joel@jms.id.au, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, eajames@linux.ibm.com, 
	minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 9:04=E2=80=AFAM Ninad Palsule <ninad@linux.ibm.com>=
 wrote:
>
> Hi Rob,
>
> On 1/14/25 17:57, Rob Herring (Arm) wrote:
> > On Tue, 14 Jan 2025 16:01:37 -0600, Ninad Palsule wrote:
> >> Allow parsing GPIO controller children nodes with GPIO hogs.
> >>
> >> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> >> ---
> >>   .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++=
++
> >>   1 file changed, 6 insertions(+)
> >>
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
>
> I am not seeing any error even after upgrading dtschema. Also this mail
> also doesn't show any warning. Is this false negative?

I believe this happens when a prior patch in the series has an error.

Rob

