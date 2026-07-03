Return-Path: <linux-aspeed+bounces-4382-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFF5C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:47:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGgs30f1z2ytJ;
	Sun, 05 Jul 2026 15:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783107834;
	cv=none; b=FWRIhW4DJm3hEukOIIwd2iTnwDHh6DiEPYaPZm7637jY1JByy3QafRxWRm0ift4HQ+jU+OKRNucJUEoV3CJrxCzRUNTShmq81XE1Jzq8E5im0BX0EDDOHoMoyeqLdDwXKsSW6HUNVPSZDx6clMG+VN5k8kmHi1yQLBymd0/VHyN0bMse1yUNnx/TjSYcOc2AwrfA4jlQ4KnrHAjYFDVC4GH9EVZ/8LSbRkNW2h1r6fK/1IToM120qLWnZnQGLlPOMe/uldlQ170P9c39EtJXnMtmqGlrXYxMInX0vBu2Zy1LJwBSBDh0PzRTjyGPRUrRfySDQxhW2Jz7DAgt8ezDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783107834; c=relaxed/relaxed;
	bh=qmmZAG95RTp/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6AkePyD3BT9LBbwFQy1LyFCxl29QV2e2smDwgsXz5D7a3dTMwa/Qp9fqZ2X7UoFfKNdd/RV+gWmql/QdfVQnHObaLp0JdiBk204Q1DsybziOzs3K8wCWl0B47igkhLKOdQvbZOHiPCdlSGSlOMnQFKk9MHIAMx2Qy3i87V5DLsrLh+Q/nDA4fjZ4+aetxBy1Sm6/Zo1Mbd6CwEeRn32i379ZQaw4C1KntC5EOak/HuEk7g4Zsx+z1886DQueSaYkcUNftxzv8OHaoPHYo9Oa3e8CCnpdyxJP5C4YGJ2bvB0xu+K7eaTXXJYo3nwxQAn4PL5tmdxbJTiIVdSqf+cQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0ZwbQ4F; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CL3+2Os5; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0ZwbQ4F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CL3+2Os5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPMF2MSqz2xwM
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 05:43:53 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HiI1n494262
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 19:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qmmZAG95RTp
	/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=; b=g0ZwbQ4Fxp8RSCKppF0JkCpG46m
	IZL9lgpKtB2MG98fMp2Eetk6x/jUKWM9B4iLr2cyr0TggLUR42uycgR+HH6LVl1q
	qYaTOQFAA2HFvhnn09kA6DLClNJHb0JXw09KSUoMXJMm+0bW1nLBMzPxA86Vo40d
	IgZgqc0zloikkecM4YZLO9hc/3NBCSgblYtyVpg9UiwAyDqhm5Ayk0BIEVQXJ7vL
	wiXAZLl3svEFwMdtZXugflcoEO4rEJtFXd8dSRtQXTMK6SSN8GIzUnCNLmi4KNg2
	1PW6qN7usOBiMmNv3KbgswGU0zdTnq7gADJCvnJBxW710nhoN1OmKi1P0Ew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jytkws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 19:43:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fec599568so1497048a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783107831; x=1783712631; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmmZAG95RTp/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=;
        b=CL3+2Os5LZOdw5CpFTqqTvskQjujPIEqVDM39YH7QHM5R6MICh+f+YBelsMP1gXq4y
         nMcmNGp54eYsTKuCJNjqjWNXpSmiGD/xqoovQt5BpdHlwDO+WjN2PYgJjXQZvh/60tFp
         XsUsyTQagglGIqXagt2wP+PP26FdAurMkr39fLzhjmmMFEHs1aS4VDnCQPxNjMtDOAU6
         6fTBd0yWmBUBNYNFd+jxj57IilNU/B5gEnmB1wNOBh6kYvESgd3G3KwrA0Fn1hXk0Sk8
         lzSatfhiSSavRwhKCOHn/zd7K57vq5sJbdZcvL46GloLP5Tf/+hNVAW/SrGkUWN7Wlv+
         96fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107831; x=1783712631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmmZAG95RTp/pup9Fv8our6A1N5cYoYLphw9GF6qKjQ=;
        b=lnAoU/Gp7h8vRANPR4XogcSmHN8yCbpKaP/DnX4LlLdt2FXQUoAB5S5zepzIgj62uJ
         gHLI3TaU5Lsc7ko35gxUM62aVm54Atdze5qnjqM5vY68t506UQlZPnD3Mki3609EKDEU
         hWVMZzDA1FSafs7JWhknoj54lIxzSB7a18ES1sNlHrbF/Dn5IDIIifkmCU7VOeldULep
         Vo+wls7Ymk/8IXLeOZDLcprrF0p/Iz4d1ls3946STKdKMKrLW/sM2Cqctlc9AIYrTTLO
         K5Uc+PkHYsg2pj+BHhWUtQQJP9NwKChbPgkao2JP6nC1sNDUg+F2hj+JvVEDZcdJWcoO
         ckeA==
X-Forwarded-Encrypted: i=1; AFNElJ+STCqC6M55ppncZjHye8lLcfXI8+fvwsAwGRB+w24iQCzVZralz9FIFxkYrycGgOyS8fITA4wArIejiQM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxukhlueH6/yrbPeuGBBAiV7s2b8bD24J8SOZuuu/HgQVodr7ka
	jrFx6vFKEBdWNDX7cjERR8fXvS7wlP5GRQmqAuEEzzA0oMjAOKxm4tD1SfWrP7JnFGLq88tfyrw
	Ir9lRhYOaGGP3gYOBHC2IwtaXH+26dTPLpF43iJUzvMOKgk9oX8ejhCSmZlhKVR0HQxSz
X-Gm-Gg: AfdE7cndixiD1MkLP/c40DkF2UJySWc/QHB26VFgvPOJSus97cP9Dum6i+jT49b3DG5
	qFCKA9WxzrRKRLFXduu9y+h7UB8C/6bAZZ0cFUYQsFS08is6fIR8mkFOF7F0fcFFm/wt/0VSr3H
	fTRSyS/REhvHNy456eJDHjSsTBuix00YAmI6Q4IxaXx7QGl0zCxiS1Tpl29KokAmMR58KVfvem0
	tM0idKzF4g3egcYrX1jCDyO+p9TeuHy5DO+GOY2Yf6pXt1t3jmKpl8YOPwAl3Fqxk49/f+71JKC
	HLYk3fOxg2JANv3G8aXYaFeMtIeVoE0gW9E/2q8N5Lut0Yb5VNIR0KCaelhnjPseTbQch8eOsm6
	ggS6dJdHfoOkyO6uTOj2px2D1wH1IFbjBFlbMrw==
X-Received: by 2002:a05:6a20:244d:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c03e4e09d3mr691170637.35.1783107830599;
        Fri, 03 Jul 2026 12:43:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c03e4e09d3mr691085637.35.1783107829862;
        Fri, 03 Jul 2026 12:43:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:43:49 -0700 (PDT)
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
Subject: [PATCH 11/42] remoteproc: mtk_scp: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:24 +0530
Message-ID: <20260703193855.110619-12-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX+U08pwYIlQJZ
 +6fx4gFemBmC6huz/Qn+yQspeDDZz5aQTQDqUizfY/C1BKLUdZo2C2z89lClFKRNVv4CEBecd0k
 MkrJm9aD6DX7rw7s3VOAvScgYTDzjwQJb3vGm7QbJH1vE7pql7+12rzmCkPrfu4pcwBXdzx+fBI
 xxH79im2JJXvPzb2WFTn43c4+awUr+U+TehbW2oLAoOLiI5rhKp9mAVXl8ZS3WSjQVT38hS5MhF
 fAdcdfJXSjzyDStFjO0LzgL9qZ1BqUR5mwWlNt/RK8bPJsgwPCjbgThylWpz75Jvv5/8hrZvdr+
 TbuEq9y2fFkjtQ6TZz158PHsI8ZNQTVQ9B4fVC2HNqmYi+UwY2XvaAUWoCW2OibCtWbbN7WK9mK
 XlBm78ejc7L+kqDCk88qYMqu3sbQqHwkLtAusDBfHckrw+YJl0pmwUkE99aQzQCuzZqkaCMDcvd
 jFxdYp1jtBJBuW1CvfA==
X-Proofpoint-GUID: sphEkwsGg5lmWxrWvD1tfcOJAK1nLv4x
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a4810f7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=PC9_zsTzMDnykp_yU_MA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: sphEkwsGg5lmWxrWvD1tfcOJAK1nLv4x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE5OSBTYWx0ZWRfX8RkQZ7/pRDlg
 Q8u6nX5qO4XdEbUH2yiSHb5cnunYl3kNAzjOTW+4Tc9SGYU1hqRnbKkXvc8iQ3xbuSbcsQJ7CXs
 EJWBrFtwcSReu57/gehL18lu2mu+x8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030199

Switch to devm_of_reserved_mem_device_init() so the reserved memory
region is released automatically when the device is unbound. Remove
the explicit of_reserved_mem_device_release() call from
scp_unmap_memory_region(). The DMA coherent buffer is still freed
explicitly there before devres releases the reserved memory region,
preserving the correct teardown order.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/mtk_scp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 85a74c9ec521..a4387649ad7f 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1027,7 +1027,7 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 	int ret;
 	const struct mtk_scp_sizes_data *scp_sizes;
 
-	ret = of_reserved_mem_device_init(scp->dev);
+	ret = devm_of_reserved_mem_device_init(scp->dev);
 
 	/* reserved memory is optional. */
 	if (ret == -ENODEV) {
@@ -1060,7 +1060,6 @@ static void scp_unmap_memory_region(struct mtk_scp *scp)
 
 	dma_free_coherent(scp->dev, scp_sizes->max_dram_size, scp->cpu_addr,
 			  scp->dma_addr);
-	of_reserved_mem_device_release(scp->dev);
 }
 
 static int scp_register_ipi(struct platform_device *pdev, u32 id,
-- 
2.53.0


