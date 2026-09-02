Return-Path: <linux-aspeed+bounces-4927-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CAAC61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:19:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0Zl4r5dz2y22;
	Thu, 03 Sep 2026 10:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380224;
	cv=none; b=P3JUZGyJBQ2P5yQzmVUDJukCx8x7H8mG6Mq4Ibpll8Jd84ipcgGeK8IV70lu14G0k8EgLNrzj7LAJS66OTJ6KTYPY92vT13lgihUz4JsCZCHZM2SYhf4FgssTmTegEBYSrQWXVpWg9EftFajZz0XpfhZVq9Qk8w8QfY6yKLUdT9I1UTJZPetbg+LZDfnOtufs1zaLCCxhlz+nxeX3kcSZriWi1Bm9MKKZd3Ayim2xd8LMv+s+jCI9yZSNI7J01UKTnhbEl96tnQiQKik6ZQ7t9geD9PNttNwZrMBXeaCSzOudaPIZlttrd+1JbcbjRL4GqHXkTxKzvMU629q0XChQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380224; c=relaxed/relaxed;
	bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohahT+j6al9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpP0QyVUppT/X4hH0/ld8jCeI/SmgWauaKiBTATgcuZggOmFL3QoGVXTdTdHpgtfq7HvyyV3h+setKnfJd9EscQ/3gX3UQj5bLg7PZ+Kj9SK+l5mV8bxxh2gCGb/IlxdUENv/B8FrsXVnezB1pj+K8lptA0UGXVLjujmkJiOyOZXqa7jp3SYRVGbYeQHakcEKPGZa1h994tGVWjwmy7Karlzq5CAj/+3vdJs0965yj7Q4+swc4KjKoEFg+sfaIRu21suvWElTuZAHRDbusFz92cPVv19Je34/Bicp2ynIs7LS+r8iy2dA16EieK2F0Sdq09lD3YjTqI/bZOKTArAEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WPo3DI7A; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=it5BZjGZ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WPo3DI7A;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=it5BZjGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvCM1Swdz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:16:56 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HrRoT2483423
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohah
	T+j6al9s=; b=WPo3DI7A9bAW4tlVrg0bqu4V+styJyUGUWS5W2JZCHN1MQPiTEi
	B/GveQ3mT/MrXBHqngiJvivPBht8vzfcWMVEe4SKqmIWxL6trNRvOAqeBCQxa9Cr
	CWxC7O6PRXcoIuZHFmx9f3HHaBfZ14Fm6UC9YMn3bMaA2GNvqkFiKTdYJzVrn8z0
	hJOGd1ybUsWB3nmQ5aLfFb0YTMEd1iqn7U0jVHt4/SGXznL8v5A7BR7nOU0B/Gyh
	gwvi2r+y7o9EnlAP8R003zg6xp9/l3tKssS7AOrIDul135GXM5UYereiVFD5t9Xu
	q6VoVNFAk528wRFtBLUFlQ4ltt5gNafAp0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9q7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:16:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so2019429a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380212; x=1788985012; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohahT+j6al9s=;
        b=it5BZjGZirGClaipj2p0OApRRZkbiJ8HQPaq1KHnfHtdSZL/9pHm+UoYiHVGiLYRz4
         hMmdxtZlvRjr7KITsYyvB9EgU8nOQCV+KdEHTVocfwLt3SULgKaH0m31EdOMMN5vE2KU
         AtRH6dNrmry7ILYWBkECrKPJEkIKaRiWKpYQvq7+6I8l5ciIk4F3O9Tsa7mm1QQwmUe7
         YS4Kr95jjyAhDegYrpeeB9KYhDc4Ar0oL2X9G0xg2VqaWIajKbGBWa9Gi8VG3Wf/fJEC
         ngmnyMTbp9bkC9qikNRxwlyzbKdn5004hME6Pc0KX6D3ZgS39z/wLnniyOxaEj37gyHv
         iyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380212; x=1788985012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohahT+j6al9s=;
        b=smhVEu1HUJ5BGjxuZKz9LtPPbbTy+rZatA7Imd3x2EVhCo5fCD3ewxf91MHtZW/Wkt
         ZFQMlzjsXMgb9gKnfmjtjffd/ZymP4F+lY3t6pL1CBYjb/Uiy0oCRMvOk1aZHMo+85Jf
         GOTfSemqjQHW1C4t8O0UWR3II2P0nB7vGu22QCQ73cwjGScdj7zCa+TFxYSZHuhoLcKk
         tMCw0m6VCeFQA1m6CJ4+ALB0Z1nieGp8ShHD1fg+TjdQO1/dltC9aE4lqMcja7kI8uS6
         A7b7znTDmWu0ldJmAljibjqHQkbxgSUxRH2218NCi1Qpd+H+mtzpBshfUO+H5PAh+utb
         9GiQ==
X-Forwarded-Encrypted: i=1; AKwUvBznvHKnDZt2YE+h+n+uYRgwWSSyRsRWJDBJ5+I7kYA2kGPoLgDEphsOFGBwwvvdzKssL6gAEjiu69X5ij8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m/f/7BfD7ecNVekNKc3u91llqIPcB8GIYl7PSMdIqnkEhPuQy1
	KHo8hepNaRy2+4mDUrYiPLxLwOI51eUTbDDnzgNdrpeTqcCwfY3zhV0Hoot8/0+h+NDaXDc97hD
	4cC1AJrhwVz6r+DrM24cGuBLOBuMSFmclTaTz5a9lwvmjxrX6Q7sXeXbKQuyKnq8j5LSS
X-Gm-Gg: AYBFou1tRld7uZamUBbktR71RyNH2oKOG/hlPGje805BotwfKxLpbSjHIsCQ+Hs6p6P
	M9XOwQNHVqMYg6E9OGKNqB6GVf/8fhchu4DQL50xhCJ9T4ZLmidBX2+M0yk9aJWc4RoBN3pEWgG
	DU3FH6H+xXZR04I6AnAyHiJPrvKGJXOCP80pVGk2ixfqIxh/kguqPIOtdyWOceExeOmj1MQ+zs0
	McLHTHcK4AMjBWSWF3DdEaGnUXiUjfsJzC5leEA+zpGC4hBi3tu/u/5zU+pXxJtEI0jI8+wUlS7
	dhQ2Ey492vi29pmwasMPPzbEfwJkrBXSTeo4NZATMSz2UNUkyCkzFh2OXu66wpwI9vc/I/bW3S2
	B/XkRv+qGxl7bcUetg/lmPZZVC4A=
X-Received: by 2002:a17:90a:c107:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39aedf7c6bbmr11956075a91.1.1788380212433;
        Wed, 02 Sep 2026 13:16:52 -0700 (PDT)
X-Received: by 2002:a17:90a:c107:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39aedf7c6bbmr11955961a91.1.1788380211806;
        Wed, 02 Sep 2026 13:16:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:16:51 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 0/11] drm: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:29 +0530
Message-ID: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZUiQZislZ3Pn0zoQ7MH2mKPrK4eNyJZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX0/09SLwoxt4y
 F0QKMv2l1gSatEedzoX2bQ8K8L4fmGeuRirgxvk9f69xJPP/3zcZ0B/whhUUHh5QhLXbKi5lgXA
 f9GWYLYCxUMRF2nfXe9DstrVxKFV/uTiElJ8ur/x7tyM66RtxH7ZParB8Dtdl+8Z7VHxMEEdqav
 yTk0Iew3KYlkVSZ2R6apoVnYkE8jxtFYGUHaf5jOi9849c40WSAYtTmEZxSVz/MuW8JqFQkAKnO
 WUdi4v5ISKkQr13gghPZ5peAe1z6rPvB8FkWudo9Y8B5sXx4GckckiyCgEhPdIJVxwx+g9N1p0O
 7+gRjr8HXl/NLFm8Z+US7lwLVd3DqxycDfy7lRygpmwU9aat+9SNKKisVh/tgdsSu2oWOzo0mOR
 QquLBEmw3csbH8oZt0LtHNqM+vKhpPIezbqBf1pNRF41+eo01NPrteUbqz3421RiHS/jJ4SxGez
 hQS9Le5adc0Bbhzm3FQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXygzHaZ8zXMzw
 WdcIJgCpeAjp5uECR/RY15sXyK1+tuLoefspV2ZgywNBHjH0i3U5Bxax2DXkron7yi00AR4kIR3
 wC90ihx1TAl4uIW/0TULtyVqm6fjG/Q=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a988435 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nZq82LKI3H6k8voUjgcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ZUiQZislZ3Pn0zoQ7MH2mKPrK4eNyJZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Several DRM drivers manually manage reserved memory lifetime by pairing
of_reserved_mem_device_init() with an explicit of_reserved_mem_device_release()
in the remove or unbind path. Missing the release on any error path between
the two calls leaks the region for the lifetime of the driver.

devm_of_reserved_mem_device_init() was recently introduced to tie the
release to the device's devres lifetime automatically. Convert the affected
DRM drivers to use it.

Note for drivers using the component framework (hdlcd, malidp, sun4i): the
previous code called of_reserved_mem_device_release() explicitly in the
component unbind callback. After conversion, the release happens at device
removal (devm teardown) rather than at component unbind. For standard CMA
or system heap reserved memory, this is benign. Drivers relying on custom
rmem->ops with meaningful release-time side effects may need to retain an
explicit release in unbind; those cases are not known to exist for the
drivers converted here.

Changes since v1: https://lore.kernel.org/lkml/20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com/
 - Carried R-b tag if any.
 - Rebased it.

Mukesh Ojha (11):
  drm: logicvc: Use devm_of_reserved_mem_device_init()
  drm: hdlcd: Use devm_of_reserved_mem_device_init()
  drm: pl111: Use devm_of_reserved_mem_device_init()
  drm: komeda: Use devm_of_reserved_mem_device_init()
  drm: malidp: Use devm_of_reserved_mem_device_init()
  drm: ingenic: Use devm_of_reserved_mem_device_init()
  drm: kmb: Use devm_of_reserved_mem_device_init()
  drm: sun4i: Use devm_of_reserved_mem_device_init()
  drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
  drm: aspeed: Use devm_of_reserved_mem_device_init()
  drm: arcpgu: Use devm_of_reserved_mem_device_init()

 drivers/gpu/drm/logicvc/logicvc_drm.c             | 21 ++++++++-------------
 drivers/gpu/drm/arm/hdlcd_drv.c                   |  6 +-----
 drivers/gpu/drm/pl111/pl111_drv.c                 |  4 +---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +---
 drivers/gpu/drm/arm/malidp_drv.c                  |  4 +---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c         | 13 +------------
 drivers/gpu/drm/kmb/kmb_drv.c                     | 12 ++----------
 drivers/gpu/drm/sun4i/sun4i_drv.c                 |  4 +---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c               |  4 +---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c           |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                     |  2 +-
 11 files changed, 14 insertions(+), 76 deletions(-)

--
2.34.1

