Return-Path: <linux-aspeed+bounces-4356-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C60C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:36:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGSH1lHNz2ygJ;
	Sun, 05 Jul 2026 15:36:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783122201;
	cv=none; b=Olu2suD55O1Yx9djTQy97HOOFmSd8d0/2mJfWAYrja/XJYjyj1dx/xJ011JHy/avrf5CDCYi7IxRk5sR6+kEc5mbgOOhq19Pasuf1MksLlZOoAevHbPHNnz4/Jgl+D6q+5FqVWUKZQju27Xz32iBWT+Npn5wkE0Hm5WR86QwHWMuAdoY7P0/918w1nRVZLUlRpgGI+nUfqNuV6sbb54NvHi0ZWbvzKOGFTC1soZmH/gZw5fmKrahEHfqnn8mN2MjeCNPNYFWjFI6/6te6NZS1ButW8HHMjS+kz8rjCzdboj+hY1hnkHEeQvWkcQPGeZI4sM5izHZ0iRVe/nhNj5HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783122201; c=relaxed/relaxed;
	bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2hyT46t2J+uNVnPpLIYhA9svxIEqRkrGUxUy/nS0OOcNeeVAszZEfQ9gANUDnLfzn7yoVXS/ity7oRzLyLktxOQ485shJE1rxVm7d75rVCvBpY4nsVTpjwAsA9IL50mPpOLCvYlb7HTUxsfT9aKTVqS9kMufvdhGKPtWcf6+X94TPKwkAPjxiIiqL1DUOW/CSBJHiA7s0bRJPn+jQQlKk8PgsVKg0Mc1kY2P2e9zv8ZlWcwymBp9UIK1bkQ94z7EsFq48gPjNWmUH1NJtWFJTSd9b7B9DDJTT0KCQYavgoKAZXO2OFErAyppTTLpcU8AITHLMm6a9X13gh81SjThw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwuefZpS; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fKcJicAM; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=dmitry.baryshkov@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwuefZpS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fKcJicAM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=dmitry.baryshkov@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1832 seconds by postgrey-1.37 at boromir; Sat, 04 Jul 2026 09:43:19 AEST
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsVgW4hSHz2xF8
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 09:43:17 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KQYZK1032670
	for <linux-aspeed@lists.ozlabs.org>; Fri, 3 Jul 2026 23:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ptvjiVFY55mHuzyR7IOPZN3q
	jRdO4GwgfZdidGQ+xdk=; b=MwuefZpSFTvuNgJyrkHy6OEbxdQIh4zwoxkeV0v1
	SeNT+DdlpzYtM/NzLKO5cRhFyyJnebuIF5IKibnQH9YpiTNtspV6uDvHww+LUUZw
	Z26z8Ghqy1Bdy97MgjMlCybQAcNvxhH7AanAObFO0nN5IPodyrTpWh3DwjILH5JS
	lGZlFabkn+OlzqLPqxZPmZYtMum9AdRVSTRs/wP4GOzKS3Aj0HWCmra/f6MkDSMw
	qYaBJCD0DDY6/4P6Rd9xzPP5E3hUq7S5beve23YXYe29Mo8LO5BMBx2bJeVN/Pjr
	eFrVkDRH+FB3sjLbh5P/z/JAV4UUnzJ+/KZJdzBA5COZEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5c6wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 23:12:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f18c4d1f82so14180386d6.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783120363; x=1783725163; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
        b=fKcJicAMqk0nS6XCjY8aa7+50EJMVE0cSc+e+OcUjKvylnbgql7HtfDmgNTKTY7KFY
         oX/r1sLj6djSyvCYufXkVu56jamn6DWAblFHLTWS91FzdoJCP98i9IBtdSknOqDftbjt
         2SxYASk9MtHEhy6M7pp7GXoE+DasBY4ECXsrhmBIzC4VOEKUGyGm9upFPYyjax4DKqEf
         farxeJx9GOt9Y4JbciCPjluLkaLvo0rcO7MO4Vpr+PqaxAaJWmVtkNrAD3jiEl34dOKa
         gRoZXXNwy90ZR+xv7QCZ6GWXYrHPuSid40Rq6h0tYnPD9PJ7dGTFNY6K2mQm4Bd5fGLh
         iiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783120363; x=1783725163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptvjiVFY55mHuzyR7IOPZN3qjRdO4GwgfZdidGQ+xdk=;
        b=sKzXCiNbt7ExX0UF4KIxrWuNcrVi/X5VuWb+Bd83TMdobGCc+9x7VV7ICKwSLUa2xm
         tRgdDvmB0QhYt+7gKBUvo1cUlVR0H2pspcqL5MZ8oPZgzsxASANM1xtsoFCu+nDcUCLt
         fs9AFZStTz1iLwQwATdbk6we3ESGbibmzo66X2cvIZ7d+O1tj1fb5b8cvGJbDoedDxVO
         HCEw7yMCDePU0Ei7BVo1s+AShC918ZGEvipv7jqwHaT5FyYRV+4TSRIRhFUPH87ohITe
         At27XHWv9AANDk8+nkvbBipOCbtaosA65QsOaRDAKdNWfZ38n5e16lJg3oy6scGWqbIC
         +geQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhcMnWrKiRPoHTb4gXzhqLf7XHD5O2e/bbXB3LJ3NsDmBDss1FIdZLwoINLj0p4t+4fvPu07O1ha6CaRo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxQxsRDceKMT2Za2fFPqsvHlVVHPBi02E5ndHm7TEc/qooqdaGB
	yF2jZ+TDR5LZ0buEbglIf5LAQo1HLhyhqFEwHWzdQtiPCwGkAFUCXwftqTxgwNUt7IQ7RKaSYBA
	iAjcckyDlby0nIl923JjdY0+AqljfI8IAcAIfyRdOUWI0hXfeesLs4+I0wtN78NJUU6JT
X-Gm-Gg: AfdE7ck0Zm7cu1OM4j5JnpLV9ZHX7NF34w4g54rtrbqrSGtbF8X6XwNX2lWf5CbwoSu
	svfMO3LGT6frq6YL/Zaqvg1GVYZX3l1AfXUipOEQBmAzNCLhAlnaeCRnaVzk1WozYTdDSoDIKZA
	nUPm6ZacbCMuNPbrzmVYqPvO2YjxvC9ijJITIIbex9ks8QuHR1xyBMjHG2cwojOeOY/kknH4zsz
	muka9VgQ3bCkNhr1TiX4yqcHvWEyU6U90MCqBQl1LIJYsTlag/PFBN2S3MFWJtwPV9phjwlGC3E
	hcro/XzCOJ19Y64Un77l4mHKs12YF0LVDd4nIlC8HTdJPbqCgnnXAdPN2lHs3M6ysYUTSt1XjUJ
	XYtbW2VweS0htt6FVDg2bQXB/IYjYLs2JYHAUDAAyhcSgFTowu6bQiDLNxos8s1kEgeLoJPpCRI
	WcqMpR+pfMP5FPzgKwhsKfnRlr
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id 6a1803df08f44-8f74c0a468cmr20755796d6.38.1783120363159;
        Fri, 03 Jul 2026 16:12:43 -0700 (PDT)
X-Received: by 2002:ad4:5c82:0:b0:8ea:efae:ab2c with SMTP id 6a1803df08f44-8f74c0a468cmr20754586d6.38.1783120362600;
        Fri, 03 Jul 2026 16:12:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a0asm815528e87.71.2026.07.03.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:12:40 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:12:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Fugang Duan <fugang.duan@cixtech.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
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
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 03/42] firmware: qcom: scm: Use
 devm_of_reserved_mem_device_init()
Message-ID: <6ejxrh43bkhryudrxk3lkzf2knlgv3mxtfgzhrzujw7km4n5bq@4bd2ahopzs4j>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-4-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfX2DBRR5XZHbaR
 6FS6730UzeWw3ZLK6WBtmnyhIb+YRK1PRvXznDH/ofyKlNZwYUQpIjxbSTyaTgUTcG/Tt4m+/oy
 Frcs5Y4ZBTCqQ6HT+/Qa/eeQrTxmD2E=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a4841ec cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Dn8qeLIeI0d_esIdenwA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: h_m-8dVsxPtI_AYnw_ZbGhZy8Me78THa
X-Proofpoint-GUID: h_m-8dVsxPtI_AYnw_ZbGhZy8Me78THa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzMyBTYWx0ZWRfX2X0pKFHPKE0k
 PYThTVR40T/xTWzyMN+mdiaMgnOZANmyAZWOSdUidmA3yBYV6FKPIakR/cvI6O5gXTYaMaVgyQG
 2Km5pO8YkOZOE2WaulzUyYLML+fGpV1syGInsQJ69GGKBiSDe3NKU6XRlFMQwYqJx373j6NZY5/
 uQxg97TLS6vyvjKRROHUHswhPK0hayjSuwSmQjy+gaKALWIWTpWiXJbtRAB9/Oh01TD7rn+1k4Z
 D3HKs2VkNW7mvCH+CIyf6x0EStv7Mjc0GenU7ihx2XotAMA33nrBHnAlY48nqDuTLP9qPVh6Ku2
 Oy9usFRWjreOI2aoPcCwdsPNK27iQWwoOD3KV8WYoLS+oUymivlclP/4eYuS9fwt4WFUVYUyFb1
 Lu+s0BDJeFt8SHnHwNxs17ans54V2/O765v8kb0VVnZkTmFJFOSQYrN04lMXRg7PTf3aZsDcXYS
 f4IhdQDW7SrlKkhkmdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030233

On Sat, Jul 04, 2026 at 01:08:16AM +0530, Mukesh Ojha wrote:
> Switch from of_reserved_mem_device_init() to the new resource managed
> devm_of_reserved_mem_device_init() so that the reserved memory region
> is released automatically on probe failure or device unbind. This
> eliminates the err_rmem cleanup label and the need to call
> of_reserved_mem_device_release() explicitly on error paths.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

