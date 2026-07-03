Return-Path: <linux-aspeed+bounces-4368-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF76C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:41:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGZ24b2fz2yj1;
	Sun, 05 Jul 2026 15:41:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108199;
	cv=none; b=MggbLIwAz0kkRn3ydoBkTHXsNQRMfcXS2l0/iUpJQI4MA4ASbyECwnd3EofygPmdx4SyRpKj+5A4REBc8IZRQ4IxqBvkdcvjCHw/lfwx4SeK4wKEDvGpa0DvuHLjSBCuDmvTkC6OJCvhiqLEfcu4KMxseIzXzvhAVwKyETsOTUMs48yISW/ybr1S7le58tnN7qpq5u5p94gLuwI33GTtyYd1yfjNfjDyFSJewUl4sADgqpQ503za5Th0+F64xeD6Y3qzFD+RkXjQANWeQ3aUa+JYR0GBTBUCbgYXoYANNPREodgr4USuOqL3pUCuVF65qNGEFyo5aTDf34ux9bQOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108199; c=relaxed/relaxed;
	bh=fJAbH4l7aN35pTuclYtUMnOAOaiJ55cYUVwXugzOmoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGCEdIZX5EMCMDmE/4kyQvK6hw5dsS6CgpnC5qx+lm4jjnb20sBsXvfZbD5kPJcBNwfOUVmjYAWHKFI/CftCTAbM1GXV5sL4W108C1iVFS9DjmQ/gBTuVFbYwDzogV46v023yKONrKolfVs7zFZsOeQnNU3m9yViQOal1oaxoDKmFwq+nA/EjWnyL1omBu2fuWOtLM2xXCSrmQYDLhegNc3b8+T+NlmADE50UGmz+qxJHwUjlH1h52K1e8037x2j+m6QJakWsBPYRrc7knRi23wqysc2ubHSyJsvK3XGkGmbmGp3+O6dnjSMp5uR70tmGI+4TepGD2JCnebz1K4E7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PGBoFG5D; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoSBVLmB; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PGBoFG5D;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoSBVLmB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPVG5wGsz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:49:58 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiLFt695171
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fJAbH4l7aN3
	5pTuclYtUMnOAOaiJ55cYUVwXugzOmoo=; b=PGBoFG5DKTfPJnwZmVs2dz9ZnWv
	A+19hdpiagXyD5IP+W8yCom0V+lFNNvDsvfT+c5hir8OgjtSN7GPw0oJ6p10UJHl
	Nbw7+UKC2U+0WYQL1qrudE7yNEn82i7T8GgUFpBkjWoCIvapKzamKbpq7UgBQW/J
	9Kq9VyNW4T+XauqcHK6IhKgNPypOAG3bm61xHYCdQXOz+3urQQj/Pkp894O+sKp5
	/h3FrFuq4Rg8zTy4U9mCR0AE/2hZ0DdkWlKhnNyO0v+/ezVOQjGWV0d8xJJhd9P4
	bALVJYPyqGtV+hgg6qfMBXmlZHev5jqQwlVn/HrQAckPuakW/p4cYJgbT8g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a84a629-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:49:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3810fcd9adbso1335947a91.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108196; x=1783712996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJAbH4l7aN35pTuclYtUMnOAOaiJ55cYUVwXugzOmoo=;
        b=YoSBVLmB9lKQ1KaXOd65erW10+E8jeWs8kvx5CvIqZW60yABt3EvkZDmLbZc1iongf
         aDDZQP1UE6EchtGKH3Eisg8D/zZYIUIHLmYWuHNrz0gfBqnLtP15PbxkDunCFJkkD9cV
         +DP0w7Cw6VSiy2bNffhIBV4K0dH7MaFkJmyHtZJj/FGlkCXzUIleh/8vbHgtHZ4pXSRt
         CiUxrylqlFaYryg4agHdpRrfrBI1lPNCkfxB8YKJlEugvKsl6Hcp5I+sRtan46ngn/Sd
         BQsX3lBPs7JjvvBVm7saIxYp3goKVvvw4iJM2JNXOoFFywk0f5lUyNV3VpPAhvUW7+qi
         fXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108196; x=1783712996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJAbH4l7aN35pTuclYtUMnOAOaiJ55cYUVwXugzOmoo=;
        b=WghbNgq13a40KUbwxUzSZJcbXus0jvqaDsNB5mGZw8Y5aemzFdzwvhLlrvSB1hW1y3
         x26HQdbI6gjBJWRSjy5H68qlhRJxq9KLZQZFYfUAIJhAwDn+oFvaGlR6TJekYQgEYVBg
         SkmLYHRe5oXjoOCONVKKOLuR3kf7qtfvOuDRAwFvZEYs9PNS2+mR3+fWcF0i0KLxXnCX
         X9dile+JNEy9DME8a9/nAvjYktvpWD1EfvKgvDvsAxK6hq2SqATJtP8aOgJlVuPWnhy3
         OTtQ6B0vCGnGkP1PzVeNqbtVIlk9it1rQ3HhoGuUpzYKO8sotgpHlwxIux47Yxy+jun6
         gvlg==
X-Forwarded-Encrypted: i=1; AHgh+Rpp+AR2c2s3Gswjytx818jkvwxgnrSzPl7u1fhkscMuRmeTWoo8sBFW4WsStQOOEql9njufghtMuo5y8Lo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/NkoaPAAOa9eRvUAxShG+MTQQw3IT6pAjcbbxENsB8DJe/cYh
	C+KrVzhxcKRVSmqvFKx/HVdpf6d6goscp9DBrDdCXuW2RmwaAm4XaveepyL/fbuq1z2FSU1mG1r
	s/a8E5988WYdApZApyPvAv+8uZ5V7RHcrP4rt3Dfb1ofT6PBNvs99KE3NKmrPPX8OucTO
X-Gm-Gg: AfdE7cndUua8mxK1r3NVmj6BObCgSyOVajxygwvr7X6ogaf6ijGXoYRYCi5zWF22aMr
	Jm28lD0tDNm6YOx1IVPDeaD1g7n2tFyblvczEKaHJm5Co76TWUxfw4jdNI1xFyYGoKE7gk22+cb
	1S5geB2QBNvFPDgncl1zGiy6uzPncDt3Ww1AdtMQN0a6Mp6TTiCHLFANA+6Kt1/xaLq0CgN38Av
	bRwxdJ6TtD2TFlIhBUKbrbkKIuutAAw+FbMMmRHi9byUNnEMkOvrIP+w/dbh07LOnnXMImKOOh/
	LyEFaKAyb0i0C2mxyKWYt2QOhPmDKKpxJttwPVJ9srx5W14jYMHrepp5LE31IArKGrYj2QeVH62
	LsBglB8JHIISYGSwZgvvvyIfivwZ5M7Q3++jp7A==
X-Received: by 2002:a17:90b:51:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-382808b3569mr806735a91.8.1783108195215;
        Fri, 03 Jul 2026 12:49:55 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-382808b3569mr806672a91.8.1783108194599;
        Fri, 03 Jul 2026 12:49:54 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:49:54 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
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
        Michal Simek <michal.simek@amd.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Chen <peter.chen@cixtech.com>,
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 26/42] ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:39 +0530
Message-ID: <20260703193855.110619-27-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9cZMO8kBtjM9pfLvChDHiAJCmg8VOCRK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX0bPuQEdsWZku
 X8GxFcpRaXgiArBVxO4+En7kzQFgL4lI6kykCABOEXb6+AtnY6rDrQx/oX9N9cehoH4loo7klVm
 owyE0OJ59EzDFE9QrSy6xat70LpkD+8=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a481264 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=2Epw-RBMujpMcR55kOQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX6JsTGGij1wGf
 gkL6o5GWn/qJ42awn+ShCLodMDSnH3/m8ZFqaj+DG/ardvd2zidxB2ufLJ7mcIPM+swumSM0ET0
 U/Rch3DvxBnuI8cEz+nLbfdPu11LdaUPqRjsTSxWfdFWvYBc6AgQtw/yLXBpbm6sjfrRKBrruc/
 mbMgGJFLSzzQdCTZKtKNgJACowqoMkt58P/ar8Qw4/kwTC/eh86ucdfKCVamv1Brf6cB4zB3lHu
 JYBzqP+/dnXD9EAnfHw8ctUXq3h4C3UGoL7MOV8BKW70pw1ryjp1oyEUzePn7eoHzLthEP100/m
 nBCUnBE0JDXkLlkw83EnLRQAn1SfRzH0U1tGZ3GFQQtQrzq+X+d/hhXBjO8u4xTolh8yot6LrR6
 irVA8H1GAFN/5LG4XWgX9xJlGCFSQ9tU48isfRJQKLYw0AtP6AfSmXSH//XGGjHFIK28XURBUW6
 Rxvmbb4o8z7coCuTKxw==
X-Proofpoint-ORIG-GUID: 9cZMO8kBtjM9pfLvChDHiAJCmg8VOCRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Replace the hand-rolled devm wrapper (mt8196_afe_release_reserved_mem +
devm_add_action_or_reset) with the standard
devm_of_reserved_mem_device_init(), letting the device resource manager
handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/mediatek/mt8196/mt8196-afe-pcm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mt8196/mt8196-afe-pcm.c b/sound/soc/mediatek/mt8196/mt8196-afe-pcm.c
index a1ae8322d8b6..dcee037991aa 100644
--- a/sound/soc/mediatek/mt8196/mt8196-afe-pcm.c
+++ b/sound/soc/mediatek/mt8196/mt8196-afe-pcm.c
@@ -2309,11 +2309,6 @@ static const struct reg_sequence mt8196_cg_patch[] = {
 	{ AUDIO_TOP_CON4, 0x361c },
 };
 
-static void mt8196_afe_release_reserved_mem(void *data)
-{
-	of_reserved_mem_device_release(data);
-}
-
 static int mt8196_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -2327,14 +2322,9 @@ static int mt8196_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_err(dev, "failed to assign memory region: %d\n", ret);
-	} else {
-		ret = devm_add_action_or_reset(dev, mt8196_afe_release_reserved_mem, dev);
-		if (ret)
-			return ret;
-	}
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
-- 
2.53.0


