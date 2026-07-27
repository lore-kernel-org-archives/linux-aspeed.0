Return-Path: <linux-aspeed+bounces-4574-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BCAC531D0
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 07:06:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7qQ75dbhz2yhD;
	Mon, 27 Jul 2026 17:06:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785116257;
	cv=none; b=RMiNXH2F391B3/qJZm40vWH639zHyx2REgeEfM1fQrzbWtO/IYcU1oV0zbqnL4WoeRGF4Fcvl82sQTBDCyqgSBWHWbXIZQCnZ0Pi+PMCIaA2DxavCnYGzpvqRxm0CsbZQJQgaBXudOfbwB03WO8r8XXvGqYsQFkSQM05qYjRWzInxpsN9Ro24hnb5B3fhJIGy9OkoXy/403DtxKQX7UN+p0CO67lqoGDjhAV3C2ci1IJ/MQSccTWGm/sed1iacp3My9jcfE556l3HDXGd4BtHOTaOW+ovzPhuAteLI9F2ms5EfdD7a56Ro9ONh77iJcEoLILKCbR3QgO23XpCe514A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785116257; c=relaxed/relaxed;
	bh=o3I//fWT/Ahu1TRVuSuKOsa5VptGAjlzU/RAQ0KA2Gs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kUjCmWS1O5iXf9JCp04DfiD9/khFfk3k3k8O98UYQzGN5on/LS3nkoLNk/JVDhB3f5x/82Rzsx2q82+xEuyqz3nf6bsBOwSUThtWQv20w6A4CwDX+bBKWEfb3IGW4vr02VnBQtfbdogn9aHWn91okvPVNKuUq+7tnXlpHs7oyW3Y0SGIS0iSnWx/7cfeZ2c2V9kJ8g0fn/6OxLDE0P53Vv8RdBehGQByU4kjcNx8DOvAbsBliLSuCsODlfjK8ji/qYoowRrTXYNFNBqLT9cu0+c95ZQO9QI9UMC1lRhSdZfRgkS2hP5+EhpK6NsjOUGXxv/+ZnsIZNM01eHPU+miFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=huang.ze@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=huang.ze@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7h6m57z8z2yPR
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 11:37:35 +1000 (AEST)
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
Date: Mon, 27 Jul 2026 09:37:03 +0800
Message-Id: <DK8YVZNAFKSP.1JHSI6NI6LLYZ@oss.qualcomm.com>
Cc: "Alexey Brodkin" <abrodkin@synopsys.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Joel Stanley"
 <joel@jms.id.au>, "Andrew Jeffery" <andrew@codeconstruct.com.au>, "Frank
 Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "Hans de Goede" <hansg@kernel.org>, "Alex Lanzano"
 <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 0/8] drm: replace simple display pipe users with
 atomic helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Linus Walleij" <linusw@kernel.org>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>
References: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com> <CAD++jL=x2Ya_MXrO7FGF6WDzr4dv83K8-TS2AWkA2O0Dko8G4g@mail.gmail.com>
In-Reply-To: <CAD++jL=x2Ya_MXrO7FGF6WDzr4dv83K8-TS2AWkA2O0Dko8G4g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon Jul 27, 2026 at 4:32 AM CST, Linus Walleij wrote:
> Hi Ze,
>
> On Sun, Jul 26, 2026 at 9:45=E2=80=AFPM Ze Huang <ze.huang@oss.qualcomm.c=
om> wrote:
>
>> struct drm_simple_display_pipe was meant to simplify simple DRM
>> drivers, but instead adds an extra wrapper around normal DRM atomic
>> helper setup. As noted in Documentation/gpu/todo.rst, remaining users
>> should be converted to regular atomic helpers and stop depending on the
>> simple-KMS interfaces.
>
> Are these patches independent of other stuff so they can be tested on
> top of v7.2-rc1 or do they need other stuff from drm-misc-next?
>
> Yours,
> Linus Walleij

Hi Linus, patches are independent and can be tested on v7.2-rc1.

I've seen others patches based on drm tree so I did the same. Would
switch to v7.2-rc1 if that's preferred :)

Thanks,
Ze Huang

