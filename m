Return-Path: <linux-aspeed+bounces-4405-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05882C43458
	for <linux-aspeed@archiver.kernel.org>; Mon,  6 Jul 2026 12:06:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv33h4RsKz3bby;
	Mon, 06 Jul 2026 22:06:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783326253;
	cv=none; b=VCp581zDi2T9SBMdAybNvzosrnZeCvy/V14c30whkH3OaDYhDwThGsGHzeXJECh4cHjkufuJmOCVbITkvY8NN5Llpb9sTbNHrcVhHgu73D7ZK4gnGWyFXMkvGa9Z2hHESzNjzTbf5NGuZJUUdYtkmbuoLlK40uwgGD6ahStdSZ2N/EInibtVDIq59g2nF++kRAUoQ1+awaOzgBUq9z0LfcIoNbJQa94GuoEt77OjFQqWkvX7Zsb9amrh4aYKTqyNEuZ32C4r+D3UcrH1K0KNjcy26WsatpmUqcJCviJRQIiZedziq7HvLM9dvgzjyAH0c5OJ6QV3NbvQ60i5EocVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783326253; c=relaxed/relaxed;
	bh=PyFc6hx7btg2QrJ34MAq5ZRc19BwZ2UZKdQ3fQVYlpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TLFHTfm4Ufs141wy1fx4J9cUmMwiKL5eyU3Wp+o7vkagRzSwCNi7uyHjPJV0JNaN5xkGaTZQkeEcMF8gWPPWUaOBvWXBmncIW48+wA1O5f6QymU71DGmLjQ7NH7UshLyB0jvS4aR45+LjreABmBbuvr8+8vF23F4+FYSP+If47gNAtyw72+SrUiFbJfbf+a4Hqr63PnXHxwQcSbgd078P1hHC4ZaQvG8AKK/dxSyeOm0/eYYAAsNqAvi/eHTKK5ZRi1HiSC4lXr1Jlh6DvlUQa541h7SpLfg2wVIlm0hIIwyeOG97i2QdWTvXhBWjZ4/eAHlr88m7VyZV7YK/iQh5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=huang.ze@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=huang.ze@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 76 seconds by postgrey-1.37 at boromir; Mon, 06 Jul 2026 18:24:12 AEST
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gty7c57Ppz3bps
	for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jul 2026 18:24:11 +1000 (AEST)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 16:22:24 +0800
Message-Id: <DJRCCWQOT4TA.1OPAZI88KOWLW@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 <imx@lists.linux.dev>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 0/9] drm: replace simple display pipe users with atomic
 helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Alexey Brodkin" <abrodkin@synopsys.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com> <9612bb41-db52-4169-a7fa-e57268d69e24@suse.de>
In-Reply-To: <9612bb41-db52-4169-a7fa-e57268d69e24@suse.de>
X-Migadu-Flow: FLOW_OUT

On Mon Jul 6, 2026 at 3:27 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 04.07.26 um 20:31 schrieb Ze Huang:
>> struct drm_simple_display_pipe was meant to simplify simple DRM
>> drivers, but instead adds an extra wrapper around normal DRM atomic
>> helper setup. As noted in Documentation/gpu/todo.rst, remaining users
>> should be converted to regular atomic helpers and stop depending on the
>> simple-KMS interfaces.
>>
>> This series converts the following drivers:
>>
>>    - arcpgu
>>    - aspeed
>>    - imx lcdc
>>    - mcde
>>    - pl111
>>    - gm12u320
>>    - repaper
>>    - tve200
>>    - xen frontend
>>
>> Each patch replaces drm_simple_display_pipe_init() with explicit
>> primary plane, CRTC and encoder setup, and moves the old simple-pipe
>> callbacks into regular plane and CRTC helper callbacks named according
>> to local driver conventions.
>>
>> The conversions preserve helper behavior that used to be implicit in
>> drm_simple_kms_helper.c, including plane-state validation, CRTC
>> primary-plane checks, affected-plane propagation, framebuffer prepare
>> handling, and existing event/vblank flow where applicable.
>>
>> Result is less helper indirection and more explicit driver-side atomic
>> wiring, with no remaining simple-KMS dependency in these drivers.
>>
>> These changes are build-tested only. No hardware testing has been
>> performed on the affected devices.
>
> Thanks a lot for the series. That's quite a nice cleanup.=C2=A0 Did you u=
se=20
> any AI to create these patches?
>

Hi Thomas,

Yes, I did. I wrote the first two conversion patches (arcpgu and
aspeed) myself to understand the migration pattern. For the remaining
drivers, I used GPT-5.5 to help with the repetitive boilerplate
conversion.

I should have reviewed the generated code more carefully before sending
the series. The sashiko-bot feedback shows that I missed several important
details, including commit-local state handling, the implicit NULL fb /
visibility checks from simple-KMS, and vblank/pageflip event ordering.
I am now going through these issues more carefully and working out the
correct fixes before sending a v2.

Do you expect AI assistance to be mentioned in the cover letter or commit
messages in some specific form? If there is a preferred tag or wording
for this, I will use it in v2.

For issues that appear to be pre-existing but are exposed or carried over
by the migration, which is better?

1. Include them as separate prep/fix patches at the beginning of the v2
series, before the corresponding conversion patches; or
2. address those pre-existing issues in a separate follow-up series?

Thanks for your time and review. :)

> Best regards
> Thomas
>

Best regards,
Ze

